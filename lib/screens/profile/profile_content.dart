import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/profile/widget/profile_form_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../data/api/api_service.dart';
import '../../routes/routes.dart';
import '../../utils/provider/profile_image_provider.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';
import '../../widget/profile_image_widget.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  bool isEditingProfile = false;
  late UserProfileManager userProfileManager;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _firstName;
  late TextEditingController _lastName;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    userProfileManager = UserProfileManager(context);
    _fetchUserProfile();
  }

  // Fungsi untuk mengambil profil user
  void _fetchUserProfile() async {
    final preferenceSettingsProvider =
    Provider.of<PreferenceSettingsProvider>(context, listen: false);

    try {
      final jwtToken = preferenceSettingsProvider.jwtToken;
      await userProfileManager.fetchUserProfile(jwtToken!);
    } catch (error) {
      // Handle error
    }
  }

  // Fungsi untuk logout
  void _logout() async {

    Navigator.pushReplacementNamed(context, Routes.loginScreen);
  }

  // Fungsi untuk mengupdate gambar profil
  void _updateProfileImage() async {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context, listen: false);
    final jwtToken = Provider.of<PreferenceSettingsProvider>(context, listen: false).jwtToken;
    final imagePath = profileImageProvider.imagePath;
    print('JWT Token: $jwtToken');
    print('Image Path: $imagePath');

    if (jwtToken != null && imagePath != null) {
      try {
        await profileImageProvider.updateProfileImage(imagePath);
        print("Gambar profil berhasil diubah");
        context.showCustomFlashMessage(
          status: 'Success',
          title: 'Gambar profil berhasil diubah',
          positionBottom: false,
        );
      } catch (error) {
        print("Gagal mengupdate gambar profil: $error");
        context.showCustomFlashMessage(
          status: 'Error',
          title: 'Gagal mengupdate gambar profil: $error',
          positionBottom: false,
        );
      }
    }
  }

  Future<void> _updateProfile(String firstName, String lastName) async {
    final preferenceSettingsProvider = Provider.of<PreferenceSettingsProvider>(context, listen: false);
    final jwtToken = preferenceSettingsProvider.jwtToken;

    try {
      await ApiService().updateProfile(jwtToken!, firstName, lastName);
      // Pembaruan profil berhasil, Anda dapat menambahkan logika tambahan jika diperlukan.
      context.showCustomFlashMessage(
        status: 'Success',
        title: 'Profil berhasil diperbarui',
        positionBottom: false,
      );
    } catch (error) {
      print("Gagal mengupdate profil: $error");
      context.showCustomFlashMessage(
        status: 'Error',
        title: 'Gagal mengupdate profil: $error',
        positionBottom: false,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'Kembali',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 14,
                            color: blackColor20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          'Akun',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 14,
                            color: blackColor20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  ProfileImageWidget(),
                  const SizedBox(height: 4.0),
                  Text(
                    '${preferenceSettingsProvider.firstName} ${preferenceSettingsProvider.lastName},',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 30,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 38.0),
                  Form(
                    key: _formState,
                    child: ProfileFormWidget(
                      emailController: _email,
                      firstNameController: _firstName,
                      lastNameController: _lastName,
                    ),
                  ),
                  SizedBox(height: 8,),
                  ButtonWidget(
                    onPress: () {
                      if (isEditingProfile) {
                        _updateProfileImage();
                        final newFirstName = _firstName.text; // Mendapatkan nilai terbaru dari field firstName
                        final newLastName = _lastName.text;   // Mendapatkan nilai terbaru dari field lastName

                        _updateProfile(newFirstName, newLastName); // Memanggil fungsi _updateProfile
                      } else {
                        // Ketika bukan dalam mode editing, isEditingProfile diatur ke true
                        setState(() {
                          isEditingProfile = true;
                        });
                      }
                    },
                    title: isEditingProfile ? 'Simpan' : 'Edit Profile',
                    buttonColor : isEditingProfile? Colors.white : Colors.redAccent,
                    titleColor: isEditingProfile? Colors.redAccent : Colors.white,
                    borderColor: Colors.redAccent,
                    paddingHorizontal: 22.0,
                    paddingVertical: 16.0,
                  ),

                  SizedBox(height: 16,),
                  ButtonWidget(
                    onPress: () {
                      if (isEditingProfile) {
                        // Tombol "Batalkan" ditekan
                        setState(() {
                          isEditingProfile = false; // Mengembalikan ke keadaan awal
                        });
                      } else {
                        _logout();
                      }
                    },
                    title: isEditingProfile ? 'Batalkan' : 'Logout',
                    buttonColor: isEditingProfile ? Colors.redAccent : Colors.white,
                    titleColor: isEditingProfile ? Colors.white : Colors.redAccent,
                    borderColor: Colors.redAccent,
                    paddingHorizontal: 22.0,
                    paddingVertical: 16.0,
                  ),


                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
