import 'package:flutter/cupertino.dart';

class PromoItem extends StatelessWidget {
  final String imageUrl;

  const PromoItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}
