import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/prefference_setting_provider.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/service_model_provider.dart';

import '../../data/api/api_service.dart';
import 'banner_provider.dart';

class UserProfileManager with ChangeNotifier {
  final BuildContext context;

  UserProfileManager(this.context);

  Future<void> fetchUserProfile(String jwtToken) async {
    final preferenceSettingsProvider = Provider.of<PreferenceSettingsProvider>(
        context,
        listen:
            false); // Gunakan PreferenceSettingsProvider untuk mengakses preferensi pengguna
    final apiService = ApiService();

    try {
      final profileData = await apiService.getProfile(jwtToken);

      preferenceSettingsProvider.setProfileImage(profileData.data.profileImage);
      preferenceSettingsProvider.setFirstName(profileData.data.firstName);
      preferenceSettingsProvider.setLastName(profileData.data.lastName);
      preferenceSettingsProvider.setEmail(profileData.data.email);
      notifyListeners(); // Notifikasi perubahan
    } catch (error) {
      // Tangani kesalahan
    }
  }

  Future<void> fetchBalance(String jwtToken) async {
    final apiService = ApiService();

    try {
      final balanceModel = await apiService.getBalance(jwtToken);
      final preferenceSettingsProvider =
          Provider.of<PreferenceSettingsProvider>(context, listen: false);
      preferenceSettingsProvider.setBalance(balanceModel.balance);
      notifyListeners(); // Notifikasi perubahan
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchServices(String jwtToken) async {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);

    try {
      await serviceProvider.getServicesFromAPI(jwtToken);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> fetchBanners(String jwtToken) async {
    final bannerProvider = Provider.of<BannerProvider>(context, listen: false);
    try {
      await bannerProvider.getBannersFromAPI(jwtToken);
    } catch (error) {
      print(error.toString());
    }
  }
}
