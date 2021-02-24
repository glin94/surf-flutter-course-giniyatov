import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  Виджет для отображения картинок
class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container()
        : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (c, o, trace) => Container(),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: const CupertinoActivityIndicator(
                  radius: 16,
                  animating: true,
                ),
              );
            },
          );
  }
}
