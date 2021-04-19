import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/search_bar.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/common/widgets/small_sight_picture.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_details.dart';

/// Экран поиска
class SightSearchScreen extends StatefulWidget {
  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  SearchInteractor _searchInteractor = SearchInteractor();
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.addListener(() async {
      _searchInteractor.searchPlaces(_textController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(sightListScreenTitle),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            title: SearchBar(
              textEditingController: _textController,
              enable: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            sliver: SliverFillRemaining(
              child: StreamBuilder<List<Place>>(
                  initialData: [],
                  stream: _searchInteractor.placesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const EmptyPlaceScreen(
                        header: "Ошибка поиска",
                        iconsAssetText: icSearch,
                      );
                    } else
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const _EmptyStateWidget();
                          break;
                        case ConnectionState.waiting:
                          return const WaitingIndicator();
                          break;
                        case ConnectionState.active:
                          return _textController.text.isEmpty
                              ? _SearchHistory(
                                  searchInteractor: _searchInteractor)
                              : snapshot.data.isEmpty
                                  ? const _EmptyStateWidget()
                                  : _SearchSightsList(list: snapshot.data);
                          break;
                        default:
                          return _SearchHistory(
                              searchInteractor: _searchInteractor);
                      }
                  }),
            ),
          )
        ],
      ),
    );
  }
}

/// Заглушка для пустого списка
class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyPlaceScreen(
      iconsAssetText: icSearch,
      header: emptySearchText,
      text: emptySearchText2,
    );
  }
}

/// История поиска
class _SearchHistory extends StatelessWidget {
  final SearchInteractor searchInteractor;

  const _SearchHistory({Key key, this.searchInteractor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<String>>(
        stream: searchInteractor.wordsListStream,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          return snapshot.hasData
              ? snapshot.data.isEmpty
                  ? Container()
                  : ListView(
                      children: [
                        Text(
                          seacrhHistoryText,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          separatorBuilder: (c, i) => const Separator(),
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              snapshot.data[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Theme.of(context).disabledColor),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).disabledColor,
                              ),
                              onPressed: () =>
                                  searchInteractor.removeHistorySearchItem(
                                      snapshot.data[index]),
                            ),
                          ),
                        ),
                        _ClearHistoryButton(searchInteractor: searchInteractor)
                      ],
                    )
              : Container();
        },
      ),
    );
  }
}

/// Кнопка очистки истории
class _ClearHistoryButton extends StatelessWidget {
  const _ClearHistoryButton({
    Key key,
    @required this.searchInteractor,
  }) : super(key: key);

  final SearchInteractor searchInteractor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          clearHistoryText,
          style: textSubtitle1.copyWith(
            color: colorLightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: searchInteractor.removeAllHistorySearchItem,
      ),
    );
  }
}

/// Результат поиска
class _SearchSightsList extends StatelessWidget {
  final List<Place> list;
  const _SearchSightsList({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (c, i) => Padding(
        padding: const EdgeInsets.only(left: 72.0),
        child: const Separator(),
      ),
      itemBuilder: (BuildContext context, int index) =>
          _SearchListTile(sight: list[index]),
    );
  }
}

/// Элемент списка поискового результата
class _SearchListTile extends StatelessWidget {
  final Place sight;
  const _SearchListTile({
    Key key,
    this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 11),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (context) => SightDetails(id: sight.id),
      ),
      title: Text(sight.name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          sight.type,
          style: textCaption.copyWith(
            color: colorLightSecondary2,
          ),
        ),
      ),
      leading: SmallSightPictureWidget(
        imageUrl: sight.urls.first,
        size: 56,
      ),
    );
  }
}
