import 'package:flutter/material.dart';

class ListPromoWidget extends StatefulWidget {
  const ListPromoWidget({Key? key}) : super(key: key);

  @override
  _ListPromoWidgetState createState() => _ListPromoWidgetState();
}

class _ListPromoWidgetState extends State<ListPromoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: promoImages.map((imagePath) {
            return Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: PromoItem(imagePath: imagePath),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PromoItem extends StatelessWidget {
  final String imagePath;

  const PromoItem({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath);
  }
}

// Daftar gambar promo
final List<String> promoImages = [
  'assets/mobile_assets/Banner 1.png',
  'assets/mobile_assets/Banner 2.png',
  'assets/mobile_assets/Banner 3.png',
  'assets/mobile_assets/Banner 4.png',
  'assets/mobile_assets/Banner 5.png',
];
