import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const svgName = 'Assets/Vectors/error.svg';

class ErrorLoadedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SvgPicture.asset(
              svgName,
              width: 300,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              'Connection Failed with Server',
              style: TextStyle(
                fontSize: 26,
                fontFamily: 'Montserrat',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
