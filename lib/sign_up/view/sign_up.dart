import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/login/view/loginPage.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      navigateTo(context, const LoginPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account: \$e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * 0.01,
              right: MediaQuery.of(context).size.height >= 750
                  ? MediaQuery.of(context).size.height * 0.08
                  : MediaQuery.of(context).size.height * 0.12,
              child: _buildLogo()),
          _buildTextField(),
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
          CustomTextfield(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
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
              ? CircularProgressIndicator()
              : Customloginbutton(
                  buttonText: "CREATE MY ACCOUNT",
                  onPressed: _createAccount,
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
