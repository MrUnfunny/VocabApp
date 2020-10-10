import 'package:flutter/material.dart';

class HorizontalScrollCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
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
                "Abstract",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text("data")
            ],
          ),
          Icon(
            Icons.bookmark_border_outlined,
            size: 34.0,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
