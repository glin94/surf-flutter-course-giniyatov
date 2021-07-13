import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/util/const.dart';

class SmallPictureOfPlaceWidget extends StatelessWidget {
  const SmallPictureOfPlaceWidget({
    Key key,
    @required this.imageUrl,
    this.size,
    this.onRemove,
  }) : super(key: key);

  final String imageUrl;

  final double size;

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          key: ValueKey(imageUrl),
          imageUrl: imageUrl,
          height: size,
          width: size,
          placeholder: (w, s) => const WaitingIndicator(),
          errorWidget: (c, t, _) => Image.asset(
            imgPlaceHolder,
            fit: BoxFit.cover,
          ),
          imageBuilder: (c, image) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image,
              ),
            ),
          ),
        ),
        onRemove == null
            ? SizedBox.shrink()
            : Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                    onTap: onRemove, child: SvgPicture.asset(icRemove)),
              )
      ],
    );
  }
}
