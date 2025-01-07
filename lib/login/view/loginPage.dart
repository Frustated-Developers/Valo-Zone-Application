import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/home/view/homepage.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            buttonText: "LOGIN",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                navigateTo(context, Homepage());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Center(
      child: Row(
        children: [
          // Facebook login button
          Container(
            color: const Color(0XFF1877F2),
            height: 40.h,
            width: 100.w,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(AssetPath.fb),
            ),
          ),
          SizedBox(width: 20.w),

          // Google login button
          Container(
            color: Colors.white,
            height: 40.h,
            width: 100.w,
            child: Padding(
              padding: MediaQuery.of(context).size.height >= 750
                  ? const EdgeInsets.all(10.0)
                  : const EdgeInsets.all(8.0),
              child: Image.asset(AssetPath.google),
            ),
          ),
          SizedBox(width: 20.w),

          // Apple login button
          Container(
            color: Colors.black,
            height: 40.h,
            width: 100.w,
            child: Image.asset(AssetPath.apple),
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        Checkbox(
          activeColor:
              _isChecked ? AppColors.SelectedIconColor : Colors.white70,
          checkColor: Colors.white, // Tick color should be white
          fillColor: MaterialStateProperty.all(
            _isChecked ? Colors.red : Colors.grey.shade50,
          ),
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue ?? false; // Update the checkbox state
            });
          },
        ),
        const Text(
          "Stay signed in",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.whiteText),
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
              fontWeight: FontWeight.bold,
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
                fontSize: 12),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
