import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

//Карточка
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({
    Key key,
    @required this.sight,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: _buildTop(sight.url),
          ),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildTop(String url) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          foregroundDecoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
              ),
              backgroundBlendMode: BlendMode.multiply,
              color: Colors.transparent.withOpacity(.4),
              gradient: gradient),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
            child: ImageWidget(
              url: url,
            ),
          )),
      Positioned(
        top: 16,
        left: 16,
        child: Text(
          sight.type,
          style: textSmallBold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        top: 18,
        right: 19,
        child: SvgPicture.asset(
          icHeart,
          color: Colors.white,
        ),
      ),
    ]);
  }

  Container _buildBottom() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: colorBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sight.name,
            maxLines: 2,
            style: textRegular.copyWith(
              color: colorLightSecondary,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            openOrCloseText(sight),
            maxLines: 1,
            style: textSmall.copyWith(
              color: colorLightSecondary2,
            ),
          ),
        ],
      ),
    );
  }
}
