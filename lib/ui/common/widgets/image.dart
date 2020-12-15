import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  ///  Виджет для отображения картинок

  const ImageWidget({
    @required this.url,
    Key key,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CupertinoActivityIndicator(
            radius: 16,
            animating: true,
          ),
        );
      },
    );
  }
}
