import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import '../utils/provider/prefference_setting_provider.dart';
import '../utils/provider/profile_image_provider.dart';
import 'package:path/path.dart' as path;

class ProfileImageWidget extends StatefulWidget {
  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final profileImageProvider = context.read<ProfileImageProvider>();
      final imageFile = File(pickedImage.path);

      // Memeriksa format gambar
      final validExtensions = ['.jpeg', '.jpg', '.png'];
      if (!validExtensions.contains(path.extension(imageFile.path))) {
        // Tampilkan pesan kesalahan jika format gambar tidak sesuai
        context.showCustomFlashMessage(
          status: 'Error',
          title: 'Format file gambar harus jpeg atau png',
          positionBottom: false,
        );
        return;
      }
      // Memeriksa ukuran gambar
      final maxSizeInBytes = 100 * 1024; // 100 KB
      if (imageFile.lengthSync() > maxSizeInBytes) {
        context.showCustomFlashMessage(
          status: 'Error',
          title: 'Ukuran file gambar tidak boleh lebih dari 100 KB',
          positionBottom: false,
        );
        return;
      }

      // Jika format dan ukuran sesuai, simpan path gambar terpilih
      profileImageProvider.setImagePath(pickedImage.path);
      print('Image Path dari Galeri: ${pickedImage.path}');
    }
  }


  @override
  Widget build(BuildContext context) {
    final imagePath = context.select((ProfileImageProvider provider) => provider.imagePath);
    final updatedProfileImage = context.select((ProfileImageProvider provider) => provider.imageUrl);
    final preferenceSettingsProvider = context.watch<PreferenceSettingsProvider>();
    final profileImage = preferenceSettingsProvider.profileImage;

    return Stack(
      children: [
        if (updatedProfileImage != null)
          CircleAvatar(
            backgroundImage: NetworkImage(updatedProfileImage),
            radius: 50,
            backgroundColor: Colors.white,
          )
        else if (profileImage != null && profileImage != "https://minio.nutech-integrasi.app/take-home-test/null")
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
            radius: 50,
            backgroundColor: Colors.white,
          )
        else if (imagePath != null)
            CircleAvatar(
              backgroundImage: FileImage(File(imagePath)),
              radius: 50,
              backgroundColor: Colors.white,
            )
          else
            CircleAvatar(
              backgroundImage: AssetImage('assets/mobile_assets/Profile Photo-1.png'),
              radius: 50,
              backgroundColor: Colors.white,
            ),

        Positioned(
          bottom: 2,
          right: 2,
          child: GestureDetector(
            onTap: pickImageFromGallery,
            child: Material(
              elevation: 3,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );



  }
}
