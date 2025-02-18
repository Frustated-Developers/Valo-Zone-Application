import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_zone/login&SignUp/repository/user_repository.dart';
import 'package:valo_zone/login&SignUp/user_model/user_model.dart';
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
  bool _isGoogleUser = false;
  late UserRepository _userRepository;
  UserModel? _currentUser;
  String? _googlePhotoUrl;

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
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Check if user is signed in with Google
        _isGoogleUser = currentUser.providerData
            .any((provider) => provider.providerId == 'google.com');

        if (_isGoogleUser) {
          _googlePhotoUrl = currentUser.photoURL;
        }

        _currentUser =
            await _userRepository.getUserFromFirebase(currentUser.uid);

        if (_currentUser != null && mounted) {
          final prefs = await SharedPreferences.getInstance();
          final savedImagePath =
              prefs.getString('profile_image_${currentUser.uid}');

          setState(() {
            _usernameController.text = _currentUser!.username;
            _emailController.text = _currentUser!.email;
            _rankController.text = _currentUser!.profile.rank ?? '';

            if (!_isGoogleUser && savedImagePath != null) {
              _selectedImage = File(savedImagePath);
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error loading profile: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSave() async {
    if (!mounted || _currentUser == null) return;

    setState(() => _isLoading = true);

    try {
      String? imagePath;
      final prefs = await SharedPreferences.getInstance();

      // Handle image path based on user type
      if (!_isGoogleUser && _selectedImage != null) {
        imagePath = _selectedImage!.path;
        await prefs.setString('profile_image_${_currentUser!.uid}', imagePath);
      } else if (_isGoogleUser) {
        imagePath = _googlePhotoUrl;
      }

      final updatedUser = UserModel(
        uid: _currentUser!.uid,
        username: _usernameController.text,
        email: _emailController.text,
        profile: UserProfile(
          displayName: _usernameController.text,
          photoURL: imagePath ?? _currentUser!.profile.photoURL,
          rank: _rankController.text,
        ),
      );

      await _userRepository.saveUser(updatedUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error saving profile: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_isGoogleUser) {
      _showErrorDialog('Google users cannot change their profile picture');
      return;
    }

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
    if (_isGoogleUser) {
      _showErrorDialog('Google users cannot change their profile picture');
      return;
    }

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
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    if (_isGoogleUser && _googlePhotoUrl != null) {
      return Image.network(
        _googlePhotoUrl!,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AssetPath.dummy_avatar,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          );
        },
      );
    } else if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else if (_currentUser?.profile.photoURL != null) {
      final photoURL = _currentUser!.profile.photoURL!;
      if (photoURL.startsWith('/')) {
        return Image.file(
          File(photoURL),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          photoURL,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AssetPath.dummy_avatar,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            );
          },
        );
      }
    } else {
      return Image.asset(
        AssetPath.dummy_avatar,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
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
                Image.asset(
                  AssetPath.edit_bg,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
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
                                  child: _buildProfileImage(),
                                ),
                                if (!_isGoogleUser)
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
                          SizedBox(
                            width: 300,
                            child: Text(
                              _currentUser?.username ?? "",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              style: const TextStyle(
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
                                _buildTextField(
                                  "User Name",
                                  _usernameController,
                                  "Enter your username",
                                  enabled: !_isGoogleUser,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  "User Email",
                                  _emailController,
                                  "Enter your email",
                                  enabled: false,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  "Valorant Rank",
                                  _rankController,
                                  'Enter your rank, e.g "Bronze 1"',
                                  enabled: true,
                                ),
                                const SizedBox(height: 40),
                                _buildButton(
                                  title: "SAVE",
                                  onTap: _isLoading ? null : _handleSave,
                                  color: AppColors.SelectedIconColor,
                                  buttonColor: AppColors.whiteText,
                                ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          cursorColor: AppColors.whiteText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.dullWhiteText,
              fontSize: 12,
            ),
            fillColor: enabled
                ? const Color(0xFF192637)
                : const Color(0xFF192637).withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            color: enabled ? Colors.white : Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback? onTap,
    required Color color,
    required Color buttonColor,
  }) {
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
