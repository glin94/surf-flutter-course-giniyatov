import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

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
            child: _buildImage(sight.url),
          ),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return Stack(children: [
      Container(
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
      ),
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
        child: Image.asset(
          icHeart,
          fit: BoxFit.cover,
          width: 24,
          height: 24,
        ),
      ),
    ]);
  }

  Container _buildDetails() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: colorBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
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
            sight.isOpen
                ? "открыто"
                : "закрыто до ${sight.openingTime.hour.toString().padLeft(2, '0')}:00",
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
