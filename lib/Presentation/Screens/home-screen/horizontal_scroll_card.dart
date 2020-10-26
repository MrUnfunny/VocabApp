import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/services/local_databases/favorites.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class HorizontalScrollCard extends StatefulWidget {
  final Map word;
  final String date;
  final IconData icon;

  const HorizontalScrollCard({Key key, this.word, this.date, this.icon})
      : super(key: key);

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
            word: widget.word['word'],
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.word['word'][0].toUpperCase()}${widget.word['word'].substring(1)}",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
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
                if ((await FavDB().check({'word': widget.word['word']}))
                    .isEmpty)
                  await FavDB().add(widget.word);
                else
                  await FavDB().remove({'word': widget.word['word']});

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
