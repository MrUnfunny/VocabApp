import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/favorites_screen/screen.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/utils.dart';

class LikeScreen extends StatelessWidget {
  static const id = 'Profile_Screen';
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
                title: tr('like'),
                isTextWhite: true,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer(
                  builder: (BuildContext context, HomeProvider homeProvider,
                      Widget child) {
                    if (homeProvider.likedWords.isNotEmpty) {
                      return ListView.builder(
                        itemCount: homeProvider.likedWords.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return const SizedBox(
                              height: 10.0,
                            );
                          }
                          return ListTile(
                            title: Text(
                              capitalize(
                                homeProvider.likedWords[index - 1],
                              ),
                              style: kCardTextStyle,
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              svgAsset,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            tr('empty'),
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
