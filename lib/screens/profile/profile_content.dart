import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/profile/widget/profile_form_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../routes/routes.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';
import '../registration/widget/registration_form_widget.dart'; // Import ApiService

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
    final preferenceSettingsProvider =
    Provider.of<PreferenceSettingsProvider>(context, listen: false);

    Navigator.pushReplacementNamed(context, Routes.loginScreen);
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
                      Image.asset(
                        // preferenceSettingsProvider.profileImage ??
                        'assets/mobile_assets/Profile Photo-1.png',
                        height: 100,
                        width: 100,
                      ),
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
                        setState(() {
                          isEditingProfile = false;
                        });
                      } else {
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
                      } else {
                        _logout();
                      }
                    },
                    title: isEditingProfile ? 'Batalkan' : 'Logout',
                    buttonColor : isEditingProfile? Colors.redAccent : Colors.white,
                    titleColor: isEditingProfile? Colors.white : Colors.redAccent,
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
