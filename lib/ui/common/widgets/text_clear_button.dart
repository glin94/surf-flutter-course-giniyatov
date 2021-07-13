import 'package:flutter/material.dart';
import 'package:places/data/interactor/new_place_interactor.dart';
import 'package:provider/provider.dart';

/// Кнопка очистки формы
class TextClearButton extends StatelessWidget {
  const TextClearButton({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textController.clear();
        context.read<PlaceInteractor>().validate();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.clear,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
