import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/assets.dart';

///  Виджет для отображения картинок
class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey(url),
      placeholder: (c, s) => const WaitingIndicator(),
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (c, o, trace) => Image.asset(
        imgPlaceHolder,
        fit: BoxFit.cover,
      ),
    );
  }
}
