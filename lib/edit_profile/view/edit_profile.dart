import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  AssetPath.edit_bg,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center children horizontally
              children: [
                SizedBox(
                  width: double.infinity, // Makes Column take full width
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 140),
                        child: Image(
                          image: AssetImage(AssetPath.dummy_avatar),
                          height: 100,
                        ),
                      ),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          "Drishtant Ranjan Srivastava",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.whiteText,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Form Fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _text("User name"),
                            const SizedBox(height: 8),
                            _textForm(hint: "Enter your username", controller: _usernameController),

                            const SizedBox(height: 8),

                            _text("User Email"),
                            const SizedBox(height: 8),
                            _textForm(hint: "Enter your email", controller: _emailController),

                            const SizedBox(height: 10),

                            _text("Valorant Rank"),
                            const SizedBox(height: 8),
                            _textForm(hint: "Enter your rank, e.g \"Bronze 1\"", controller: _rankController),

                            const SizedBox(height: 20),

                            _buttons(title: "SAVE", onTap: () {}),
                            const SizedBox(height: 12),
                            // Cancel Button
                            _buttons(
                                title: "CANCEL",
                                onTap: () {},
                                color: AppColors.buttonWhite),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _text(String name) {
  return Text(
    name,
    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  );
}

Widget _textForm({String hint= "", required TextEditingController controller} ) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.greyText,fontSize: 12),
      fillColor: const Color(0xFF192637),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    style: const TextStyle(color: Colors.white),
  );
}

Widget _buttons(
    {required String title,
    required VoidCallback onTap,
    Color color = AppColors.SelectedIconColor}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
