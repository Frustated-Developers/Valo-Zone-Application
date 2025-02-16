import 'dart:io' show File;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_zone/login&SignUp/view/sign_up.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  // Single function to handle image picking from both camera and gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error picking image: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.homepageBackground,
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.SelectedIconColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: AppColors.homepageBackground,
          title: const Text(
            'Choose the preferred option :',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera, color: Colors.white),
                title: const Text(
                  'Choose Avatar',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSave() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error saving profile: $e');
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      AssetPath.edit_bg,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 245),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipOval(
                                  child: _selectedImage != null
                                      ? Image.file(
                                          _selectedImage!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          AssetPath.dummy_avatar,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: GestureDetector(
                                    onTap: _showImageSourceDialog,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteText,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.camera,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              "Drishtant Ranjan Srivastava",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTextField("User Name",
                                    _usernameController, "Enter your username"),
                                const SizedBox(height: 16),
                                _buildTextField("User Email", _emailController,
                                    "Enter your email"),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    "Valorant Rank",
                                    _rankController,
                                    'Enter your rank, e.g "Bronze 1"'),
                                const SizedBox(height: 40),
                                _buildButton(
                                    title: "SAVE",
                                    onTap: _isLoading ? null : _handleSave,
                                    color: AppColors.SelectedIconColor,
                                    buttonColor: AppColors.whiteText),
                                const SizedBox(height: 15),
                                _buildButton(
                                  title: "CANCEL",
                                  onTap: () => Navigator.pop(context),
                                  color: AppColors.buttonWhite,
                                  buttonColor: AppColors.blackText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildfooter(context),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteText,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          cursorColor: AppColors.whiteText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: Colors.white), // Set your desired color
            ),
            filled: true,
            hintText: hint,
            hintStyle:
                const TextStyle(color: AppColors.dullWhiteText, fontSize: 12),
            fillColor: const Color(0xFF192637),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildButton(
      {required String title,
      required VoidCallback? onTap,
      required Color color,
      required Color buttonColor}) {
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
          style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildfooter(BuildContext context) {
    return Column(
      children: [
        // Create account link
        GestureDetector(
          onTap: () => navigateTo(context, const SignUp()),
          child: const Text(
            "DELETE MY ACCOUNT",
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
    _usernameController.dispose();
    _emailController.dispose();
    _rankController.dispose();
    super.dispose();
  }
}
