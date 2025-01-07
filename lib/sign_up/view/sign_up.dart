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

  // Controllers for the TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
      key: _formKey, // Assign the form key
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Username field
          CustomTextfield(
            controller: _usernameController,
            hintText: 'Username',
            icon: Icons.person,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          // Password field
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
                return 'Password should be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          // Confirm Password field
          CustomTextfield(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            icon: Icons.lock_open,
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(
            height: 12.h,
          ),
          // Create Account button
          Customloginbutton(
            buttonText: "CREATE MY ACCOUNT",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // If the form is valid, navigate to the LoginPage
                navigateTo(context, const LoginPage());
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
