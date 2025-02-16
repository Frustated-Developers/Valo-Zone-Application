import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_zone/login&SignUp/repository/user_repository.dart';
import 'package:valo_zone/login&SignUp/view/loginPage.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomLoginButton.dart';
import 'package:valo_zone/utils/reusable_widgets/Custom_TextField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final UserRepository _userRepository;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeUserRepository();
  }

  Future<void> _initializeUserRepository() async {
    final prefs = await SharedPreferences.getInstance();
    _userRepository = UserRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      prefs: prefs,
    );
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Create user using repository
      await _userRepository.createUserWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: _userNameController.text.trim(),
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login page
        navigateTo(context, const LoginPage());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create account: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage(AssetPath.loginBg),
              fit: BoxFit.cover,
            ),
          ),
          _buildOpacityContainer(),
          Positioned(
            top: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.width * 0.01
                : MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.height * 0.08
                : MediaQuery.of(context).size.height * 0.12,
            child: _buildLogo(),
          ),
          _buildTextField(),
          Positioned(
            left: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.width * 0.25
                : MediaQuery.of(context).size.width * 0.35,
            bottom: MediaQuery.of(context).size.height * 0.08,
            child: _buildfooter(context),
          )
        ],
      ),
    );
  }

  Widget _buildOpacityContainer() {
    return Opacity(
      opacity: 0.5,
      child: Container(
        color: AppColors.SelectedIconColor,
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      AssetPath.icIcon,
      height: 250.h,
      width: 250.w,
    );
  }

  Widget _buildTextField() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          CustomTextfield(
            controller: _userNameController,
            hintText: 'User Name',
            icon: Icons.person,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your UserName';
              }
              if (value.length < 3) {
                return 'Username should be at least 3 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          CustomTextfield(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          CustomTextfield(
            controller: _passwordController,
            hintText: 'Password',
            icon: Icons.lock_open,
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password should be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          CustomTextfield(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            icon: Icons.lock_open,
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 12.h),
          _isLoading
              ? const CircularProgressIndicator()
              : Customloginbutton(
                  buttonText: "CREATE MY ACCOUNT",
                  onPressed: _createAccount,
                ),
        ],
      ),
    );
  }

  Widget _buildfooter(BuildContext context) {
    return Column(
      children: [
        const Text(
          "ALREADY HAVE AN ACCOUNT",
          style: TextStyle(
            color: AppColors.whiteText,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () => navigateTo(context, const LoginPage()),
          child: Row(
            children: [
              const Icon(
                color: AppColors.whiteText,
                Icons.arrow_circle_left_outlined,
                size: 20,
              ),
              SizedBox(width: 5.w),
              const Text(
                "BACK TO LOGIN",
                style: TextStyle(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
