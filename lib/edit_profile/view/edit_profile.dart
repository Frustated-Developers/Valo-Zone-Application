import 'package:flutter/material.dart';
import 'dart:io' show Platform, File;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
          backgroundColor: AppColors.homepageBackground,
          title: const Text(
            'Select Image Source',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera, color: Colors.white),
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
      // TODO: Implement your save logic here
      //1. Upload image if _selectedImage is not null
      // 2. Save form data (_usernameController.text, etc.)

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(AssetPath.ic_valo,height: 80),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      AssetPath.edit_bg,
                      height: 300,
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
                            padding: const EdgeInsets.only(top: 220),
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
                                  bottom: -10,
                                  right: -10,
                                  child: GestureDetector(
                                    onTap: _showImageSourceDialog,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: AppColors.SelectedIconColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 20,
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
                                fontSize: 24,
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
                                _buildTextField("User name", _usernameController, "Enter your username"),
                                const SizedBox(height: 16),
                                _buildTextField("User Email", _emailController, "Enter your email"),
                                const SizedBox(height: 16),
                                _buildTextField("Valorant Rank", _rankController, 'Enter your rank, e.g "Bronze 1"'),
                                const SizedBox(height: 24),
                                _buildButton(
                                  "SAVE",
                                  _isLoading ? null : _handleSave,
                                  AppColors.SelectedIconColor,
                                ),
                                const SizedBox(height: 12),
                                _buildButton(
                                  "CANCEL",
                                      () => Navigator.pop(context),
                                  AppColors.buttonWhite,
                                ),
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
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.SelectedIconColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.greyText, fontSize: 12),
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

  Widget _buildButton(String title, VoidCallback? onTap, Color color) {
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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _rankController.dispose();
    super.dispose();
  }
}