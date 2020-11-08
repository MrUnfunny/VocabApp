import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/constants/constants.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

final svgAsset = 'Assets/Vectors/empty.svg';

class FavScreen extends StatelessWidget {
  static const id = 'Favorite_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomAppBar(
                title: 'Favorites',
                isTextWhite: true,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer(
                  builder: (BuildContext context, HomeProvider homeProvider,
                      Widget child) {
                    if (homeProvider.favWords.isNotEmpty)
                      return ListView.builder(
                        itemCount: homeProvider.favWords.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0)
                            return SizedBox(
                              height: 10.0,
                            );
                          return FavCard(
                            word: homeProvider.favWords[index - 1],
                            date: homeProvider.favWords[index - 1]['date'],
                          );
                        },
                      );
                    else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              svgAsset,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Nothing Here',
                            style: kLargeTextStyle,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavCard extends StatelessWidget {
  final Map word;
  final String date;

  FavCard({Key key, @required this.word, @required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: Key(word['word']),
      onDismissed: (direction) async {
        Provider.of<HomeProvider>(context, listen: false).addtoFavorites(word);
        // await FavDB().remove({'word': word});
        Provider.of<HomeProvider>(context, listen: false).getFavorites();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${word['word'][0].toUpperCase()}${word['word'].substring(1)}',
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
