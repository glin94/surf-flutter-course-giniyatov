import 'package:flutter/material.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/strings/common_strings.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyPlaceScreen(
      iconsAssetText: icError,
      header: errorText,
      text: errorDescText,
    );
  }
}
