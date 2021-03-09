import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';

class SmallSightPictureWidget extends StatelessWidget {
  const SmallSightPictureWidget({
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
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
              onTap: onRemove, child: SvgPicture.asset(icRemove)),
        )
      ],
    );
  }
}
