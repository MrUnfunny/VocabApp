import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/utils.dart';
import 'package:provider/provider.dart';
// This widget is used to show User History on HomeScreen

class HorizontalScrollCard extends StatefulWidget {
  const HorizontalScrollCard({Key key, this.word, this.date, this.icon});

  final Map word;
  final String date;
  final IconData icon;

  @override
  _HorizontalScrollCardState createState() => _HorizontalScrollCardState();
}

class _HorizontalScrollCardState extends State<HorizontalScrollCard> {
  IconData _icon;
  @override
  Widget build(BuildContext context) {
    _icon = widget.icon;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordDetailScreen(
            word: widget.word['word'] as String,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: kLightBlack),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(widget.word['word'] as String),
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(widget.date),
              ],
            ),
            IconButton(
              icon: Icon(
                _icon,
                size: 34.0,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                if (!Provider.of<HomeProvider>(context, listen: false)
                    .favWords
                    .contains(widget.word)) {
                  Provider.of<HomeProvider>(context, listen: false)
                      .addtoFavorites(widget.word as Map<String, dynamic>);
                } else {
                  Provider.of<HomeProvider>(context, listen: false)
                      .removeFromFav(widget.word);
                }

                Provider.of<HomeProvider>(context, listen: false)
                    .getFavorites();
              },
            )
          ],
        ),
      ),
    );
  }
}
