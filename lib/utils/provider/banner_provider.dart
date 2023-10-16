import 'package:flutter/foundation.dart';

import '../../data/api/api_service.dart';
import '../../data/models/banner_model.dart';

class BannerProvider with ChangeNotifier {
  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;

  void setBanners(List<BannerModel> banners) {
    _banners = banners;
    notifyListeners();
  }

  Future<void> getBannersFromAPI(String jwtToken) async {
    try {
      final apiService = ApiService();
      final banners = await apiService.getBanners(jwtToken);
      setBanners(banners);
    } catch (error) {
      print(error.toString());
    }
  }
}
