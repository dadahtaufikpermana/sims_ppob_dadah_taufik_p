class BannerModel {
  final String bannerImage;

  BannerModel({
    required this.bannerImage,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerImage: json['banner_image'],
    );
  }
}
