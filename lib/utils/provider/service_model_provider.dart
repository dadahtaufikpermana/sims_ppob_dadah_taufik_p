import 'package:flutter/foundation.dart';

import '../../data/api/api_service.dart';
import '../../data/models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  List<ServiceModel> _services = [];

  List<ServiceModel> get services => _services;

  void setServices(List<ServiceModel> services) {
    _services = services;
    notifyListeners();
  }

  Future<void> getServicesFromAPI(String jwtToken) async {
    try {
      final apiService = ApiService();
      final services = await apiService.getServices(jwtToken);
      setServices(services);
    } catch (error) {
      print(error.toString());
    }
  }
}
