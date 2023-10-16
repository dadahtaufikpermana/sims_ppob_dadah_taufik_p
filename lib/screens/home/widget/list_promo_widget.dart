import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/provider/banner_provider.dart';
import 'banner_item.dart';


class ListPromoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    final banners = bannerProvider.banners;

    return Container(
      height: 124,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: banners.map((banner) {
            return Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: PromoItem(imageUrl: banner.bannerImage),
            );
          }).toList(),
        ),
      ),
    );
  }
}