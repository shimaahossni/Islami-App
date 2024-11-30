// features/prayerTime/page/views/evening_screen_another.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EveningScreenAnother extends StatefulWidget {
  EveningScreenAnother({super.key, required this.pageNumber});

  int pageNumber;
  int get y => pageNumber;

  @override
  State<EveningScreenAnother> createState() => _EveningScreenAnotherState();
}

class _EveningScreenAnotherState extends State<EveningScreenAnother> {
  late var azkary;
  //int pageNumber = Widge;
  Future<String> loadAzkarLoaded() async {
    var response = await rootBundle.loadString("assets/json/adhkar.json");
    setState(() {
      azkary = json.decode(response);
    });
    return "success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAzkarLoaded();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);

    var futureBuilder = FutureBuilder(
      future: loadAzkarLoaded(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Text(azkary.toString());
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.SouraDetailsScreenPng,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: mediaquery.height * .05,
            //left: mediaquery.width * .25,
            child: Text(
              azkary[widget.y]['category'].toString(),
              style: gettitleTextStyle24(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(mediaquery.height * .04),
                SizedBox(
                  height: mediaquery.height * .7,
                  width: mediaquery.width * .9,
                  child: ListView.separated(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Gap(mediaquery.height * .03),
                          Text(
                            azkary[widget.y]['array'][index]['text'].toString(),
                            style: gettitleTextStyle24(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '------- ${azkary[widget.y]['array'][index]['count'].toString()} Times-----',
                            style: gettitleTextStyle16(),
                          ),
                          Gap(mediaquery.height * .03),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
