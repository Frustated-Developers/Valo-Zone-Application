import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/landing/view/landingPage.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomLoginButton.dart';
import 'package:valo_zone/utils/reusable_widgets/Custom_TextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isChecked = false; // Track the checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage(AssetPath.loginBg),
              fit: BoxFit.cover,
            ),
          ),
          _buildOpacityContainer(),

          Positioned(
            top: MediaQuery.of(context).size.width * 0.19,
              right: MediaQuery.of(context).size.height * 0.05,
              child: _buildLogo()),

          _buildTextField(),

          Positioned(
            left: MediaQuery.of(context).size.width * 0.07,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: _buildSocialLogin(),
          ),

          Positioned(
            bottom:  MediaQuery.of(context).size.height * 0.18,
            child: _buildRememberMe(),
          ),

          Positioned(
              left: MediaQuery.of(context).size.width * 0.35,
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: _footer()),
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
    return Container(
      child: Image.asset(AssetPath.icIcon,scale: 2.3,),
    );
  }

  Widget _buildTextField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextfield(
          hintText: 'Username',
          icon: Icons.person,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            print('Value changed: $value');
          },
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
        CustomTextfield(
          hintText: 'Password',
          icon: Icons.lock_open,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            print('Value changed: $value');
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        SizedBox(
          height: 12.h,
        ),
        Customloginbutton(),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Center(
      child: Row(
        children: [
          Container(
            color: Color(0XFF1877F2),
            height: 40,
            width: 100,
            child: SvgPicture.asset(AssetPath.fb),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            color: Colors.white,
            height: 40,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(AssetPath.google),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            color: Colors.black,
            height: 40,
            width: 100,
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
          activeColor: Colors.blue, // Color of the checkbox when selected
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.all(Colors.grey.shade300), // Light grey fill color
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue ?? false; // Update the checkbox state
            });
          },
        ),
        Text(
          "Stay signed in",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

  Widget _footer() {
  return Column(
    children: [
      Container(
        child: Text("CAN'T SIGN IN",style: TextStyle(
            color:AppColors.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 12),
        ),
      ),
      Container(
        child: Text("CREATE ACCOUNT",style: TextStyle(
            color:AppColors.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 12),
        ),
      ),
    ],
  );
  }
