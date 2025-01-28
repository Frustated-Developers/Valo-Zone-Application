import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/services/login_service.dart';
import 'package:valo_zone/sign_up/view/sign_up.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomLoginButton.dart';
import 'package:valo_zone/utils/reusable_widgets/Custom_TextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false; // Track the checkbox state
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  // Add constant for shared preferences key
  static const String PREFS_IS_LOGGED_IN = 'is_logged_in';
  static const String PREFS_USER_EMAIL = 'user_email';

  @override
  void initState() {
    super.initState();
    // Check login state as soon as LoginPage initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRememberMeStatus();
    });
  }

  // Load remember me status and redirect if necessary
  Future<void> _loadRememberMeStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool(PREFS_IS_LOGGED_IN) ?? false;

    if (isLoggedIn && mounted) {
      navigateTo(context, const Homepage());
    }
  }

  // Save login state
  Future<void> _saveLoginState(String email) async {
    if (_isChecked) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PREFS_IS_LOGGED_IN, true);
      await prefs.setString(PREFS_USER_EMAIL, email);
    }
  }

  // Clear login state
  Future<void> _clearLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PREFS_IS_LOGGED_IN, false);
    await prefs.remove(PREFS_USER_EMAIL);
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
            top: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.height * 0.08
                : MediaQuery.of(context).size.height * 0.1,
            child: _buildLogo(),
          ),
          _buildTextField(),
          Positioned(
            left: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.width * 0.07
                : MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.height * 0.28
                : MediaQuery.of(context).size.height * 0.25,
            child: _buildSocialLogin(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.height * 0.20
                : MediaQuery.of(context).size.height * 0.18,
            left: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.width * 0.05
                : MediaQuery.of(context).size.width * 0.02,
            child: _buildRememberMe(),
          ),
          Positioned(
            left: MediaQuery.of(context).size.height >= 750
                ? MediaQuery.of(context).size.width * 0.35
                : MediaQuery.of(context).size.width * 0.35,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: _buildfooter(context),
          ),
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
            controller: _usernameController,
            hintText: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Email';
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
              return null;
            },
          ),
          SizedBox(height: 12.h),
          Customloginbutton(
              isLoader: _isLoading,
              buttonText: "LOGIN",
              onPressed: _handleButtonClick),
          Text(
            "OR",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            try {
              final LoginService loginService = LoginService();
              final user = await loginService.signInWithGoogle();

              if (user != null) {
                // Successfully logged in
                // Navigate to your home screen or next screen
                await _saveLoginState(_usernameController.text.trim());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Homepage(), // Replace with your home screen
                  ),
                );
              } else {
                await _clearLoginState();
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Google sign in failed. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } catch (e) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Container(
            color: Colors.white70,
            height: 45.h,
            width: 325.w,
            child: Padding(
              padding: MediaQuery.of(context).size.height >= 750
                  ? const EdgeInsets.all(11.0)
                  : const EdgeInsets.all(8.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 9.w,
                    ),
                    Image.asset(AssetPath.google),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign in with Google",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ]),
            ),
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        Checkbox(
          activeColor:
              _isChecked ? AppColors.SelectedIconColor : Colors.white70,
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.all(
            _isChecked ? Colors.red : Colors.grey.shade50,
          ),
          value: _isChecked,
          onChanged: (bool? newValue) async {
            setState(() {
              _isChecked = newValue ?? false;
            });

            if (!_isChecked) {
              await _clearLoginState();
            }
          },
        ),
        const Text(
          "Stay signed in",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteText,
          ),
        ),
      ],
    );
  }

  Widget _buildfooter(BuildContext context) {
    return Column(
      children: [
        // Can't sign in text
        Text(
          "CAN'T SIGN IN",
          style: TextStyle(
              color: AppColors.whiteText,
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ),
        // Create account link
        GestureDetector(
          onTap: () => navigateTo(context, const SignUp()),
          child: Text(
            "CREATE ACCOUNT",
            style: TextStyle(
                color: AppColors.whiteText,
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        ),
      ],
    );
  }

  void _handleButtonClick() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2)); // Add 2-second delay

      User? user = await _loginService.signInWithEmailAndPassword(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        navigateTo(context, Homepage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Are yrr!",
              contentType: ContentType.failure,
              message:
                  'We couldn\'t find an account. Try signing up or double-check your details.',
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
