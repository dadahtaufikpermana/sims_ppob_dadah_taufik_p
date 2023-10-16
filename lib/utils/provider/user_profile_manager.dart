import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/prefference_setting_provider.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/service_model_provider.dart';

import '../../data/api/api_service.dart';
import 'banner_provider.dart';

class UserProfileManager {
  final BuildContext context;

  UserProfileManager(this.context);

  Future<void> fetchUserProfile(String jwtToken) async {
    final preferenceSettingsProvider =
        Provider.of<PreferenceSettingsProvider>(context, listen: false);
    final apiService = ApiService();

    try {
      final profileData = await apiService.getProfile(jwtToken);

      preferenceSettingsProvider.profileImage = profileData.data.profileImage;
      preferenceSettingsProvider.firstName = profileData.data.firstName;
      preferenceSettingsProvider.lastName = profileData.data.lastName;
      preferenceSettingsProvider.email = profileData.data.email;
    } catch (error) {}
  }

  String? getJwtToken() {
    final preferenceSettingsProvider =
        Provider.of<PreferenceSettingsProvider>(context, listen: false);
    return preferenceSettingsProvider.jwtToken;
  }

  Future<void> fetchBalance(String jwtToken) async {
    final apiService = ApiService();

    try {
      final balanceModel = await apiService.getBalance(jwtToken);
      final preferenceSettingsProvider =
          Provider.of<PreferenceSettingsProvider>(context, listen: false);
      preferenceSettingsProvider.setBalance(balanceModel.balance);
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchServices(String jwtToken) async {
    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false);

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
      // Handle the banners as needed
    } catch (error) {
      print(error.toString());
    }
  }
}
