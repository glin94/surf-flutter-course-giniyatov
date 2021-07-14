import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/new_place_interactor.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/common/widgets/small_picture_place.dart';
import 'package:places/ui/common/widgets/text_form_field.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/category_choice_screen.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места
class AddNewPlaceScreen extends StatelessWidget {
  const AddNewPlaceScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        title: const Text(addNewPlaceTitleText),
        leading: CupertinoButton(
          child: Text(
            cancelButtonText,
            style: textSubtitle1.copyWith(
              color: colorDarkSecondary2,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Provider<NewPlaceInteractor>(
        create: (context) => NewPlaceInteractor(),
        builder: (context, w) => CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _PicturesGalleryWidget(),
                  const SizedBox(height: 24),
                  const _CategoryChoiceTile(),
                  const SizedBox(height: 24),
                  TextFormFieldWidget(
                    textController:
                        context.read<NewPlaceInteractor>().nameTextController,
                    label: placeNameText,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormFieldWidget(
                          textController: context
                              .read<NewPlaceInteractor>()
                              .latTextController,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          label: placeLatText,
                          textInputType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: const SizedBox(width: 16),
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormFieldWidget(
                          textController: context
                              .read<NewPlaceInteractor>()
                              .lonTextController,
                          maxLines: 1,
                          label: placeLonText,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const _GetMapCoordinates(),
                  const SizedBox(height: 37),
                  TextFormFieldWidget(
                    textController:
                        context.read<NewPlaceInteractor>().descTextController,
                    textInputAction: TextInputAction.done,
                    label: placeDescText,
                    maxLines: 3,
                    hintText: inputValueHintText,
                    textInputType: TextInputType.multiline,
                  ),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    child: const _CreateNewPlaceButton(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///Кнопка добавления нового места
class _CreateNewPlaceButton extends StatelessWidget {
  const _CreateNewPlaceButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeModel = context.watch<NewPlaceInteractor>();

    return StreamBuilder<bool>(
        initialData: false,
        stream: placeModel.isValidateStream,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: snapshot.data
                  ? () {
                      placeModel.createNewPlace();
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Text(
                createText.toUpperCase(),
              ),
            ),
          );
        });
  }
}

/// Выбор координат на карте
class _GetMapCoordinates extends StatelessWidget {
  const _GetMapCoordinates({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          selectMapCoordinatesText,
          style: textSubtitle1.copyWith(
            fontWeight: FontWeight.bold,
            color: colorLightGreen,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

/// Форма выбора категории
class _CategoryChoiceTile extends StatelessWidget {
  const _CategoryChoiceTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeModel = context.watch<NewPlaceInteractor>();

    return Column(
      children: [
        const CaptionText(title: placeCategoryText),
        ListTile(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (c) => CategoryChoiceScreen(),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          focusColor: colorLightGreen,
          title: StreamBuilder<String>(
              initialData: placeModel.categoryName,
              stream: placeModel.choicedCategoryControllerStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.isEmpty ? unSelectText : snapshot.data,
                  style: textSubtitle1.copyWith(
                    color: colorDarkSecondary2,
                  ),
                );
              }),
          trailing: SvgPicture.asset(
            icArrowRight,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        const Separator()
      ],
    );
  }
}

///Галерея картинок
class _PicturesGalleryWidget extends StatelessWidget {
  const _PicturesGalleryWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeModel = context.watch<NewPlaceInteractor>();
    return Container(
      height: 72,
      child: StreamBuilder<List<String>>(
          initialData: placeModel.imageList,
          stream: placeModel.imageListStream,
          builder: (context, snapshot) {
            final imgList = snapshot.data;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const _AddPictureButton(),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SmallPictureOfPlaceWidget(
                      key: ValueKey(imgList[index]),
                      onRemove: () => placeModel.deleteImage(imgList[index]),
                      imageUrl: imgList[index],
                      size: 72,
                    ),
                  ),
                ),
              ]),
            );
          }),
    );
  }
}

class _AddPictureButton extends StatelessWidget {
  const _AddPictureButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: colorLightGreen.withOpacity(0.05),
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => _PhotoChoiceDialog(),
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(76, 175, 80, 0.48),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 40,
            color: colorLightGreen,
          ),
        ),
      ),
    );
  }
}

class _PhotoChoiceDialog extends StatelessWidget {
  const _PhotoChoiceDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CupertinoActionSheet(
        cancelButton: _CancelButton(),
        actions: [
          Material(
            child: ListTile(
              onTap: () {},
              leading: SvgPicture.asset(icCamera2),
              title: Text(cameraText),
            ),
          ),
          Material(
            child: ListTile(
              leading: SvgPicture.asset(icPhoto),
              title: Text(photoText),
            ),
          ),
          Material(
            child: ListTile(
              leading: SvgPicture.asset(icFile),
              title: Text(fileText),
            ),
          ),
        ],
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          cancelButtonText.toUpperCase(),
          style: Theme.of(context).textTheme.button.copyWith(
                color: colorLightGreen,
              ),
        ),
      ),
    );
  }
}
