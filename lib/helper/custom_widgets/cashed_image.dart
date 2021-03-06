import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashedImage extends StatelessWidget {
  final String url;
  final double width, height;

  CashedImage(
      {@required this.url, @required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'sss',
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        // placeholder: placeholder,
        height: height,
        width: width,
        imageUrl: url,
        placeholder: (context, url) => Image.asset(
          'src/images/placeholder.png',
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Colors.red,
          size: 100,
        ),
      ),
    );
  }
}
