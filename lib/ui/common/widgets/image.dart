import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';

//виджет для отображения картинок
class ImageWidget extends StatelessWidget {
  final String url;

  const ImageWidget({
    @required this.url,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      foregroundDecoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
          ),
          backgroundBlendMode: BlendMode.multiply,
          color: Colors.transparent.withOpacity(.4),
          gradient: gradient),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }
}
