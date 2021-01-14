import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';
import 'package:mytouringapp/core/NavigationBar.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/DayPlannerModel.dart';
import 'package:mytouringapp/services/DayPlannerService.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:mytouringapp/core/WebViewScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_networkimage/provider.dart';


class DayPlanner extends StatefulWidget {
  String city;
  DayPlanner(String id) {
    this.city = id;
  }
  @override
  _DayPlannerState createState() => _DayPlannerState(this.city);
}

class _DayPlannerState extends State<DayPlanner> {
  String city;
  _DayPlannerState(String id) {
    this.city = id;
  }
  Future<DayPlannerModel> response;
  DayPlannerService service = DayPlannerService();
  @override
  void initState() {
    response = service.getDayPlannerDetails(city);
    print('here1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DayPlannerModel values;
    SizeConfig().init(context);
    int noOfImages;
    List<String> imageUrls = [];
    return SafeArea(
      child: Container(
        decoration: BackGroundTheme.getTheme(),
        child: Scaffold(
                  bottomNavigationBar: NavBar(1),
                  body: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomAppBar("Day Planner"),
                        FutureBuilder(
                            future: response,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                values = snapshot.data;
                                return Expanded(
                                  child: Container(
                                    //color: Colors.red,
                                      child: ListView.separated(
                                          padding: EdgeInsets.all(10),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          separatorBuilder:
                                              (BuildContext context, int index) =>
                                          const Divider(
                                            height: 5,
                                          ),
                                          itemCount: values.results[0].days.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return
                                              Container(
                                                height: SizeConfig.v[370],
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Day ' +
                                                          '${index + 1}' +
                                                          ' Itinerary',
                                                      style: GoogleFonts.pangolin(
                                                          fontWeight: FontWeight.bold,
                                                          fontStyle: FontStyle.italic,
                                                          fontSize: SizeConfig.f[20],
                                                          color: Colors.white70),
                                                    ),
                                                    getItenaryItem(index, values, city),
                                                  ],
                                                ),
                                              );
                                          })),
                                );
                              } else {
                                return Expanded(
                                  child: Container(
                                      child: Center(
                                        //child: CupertinoActivityIndicator(),
                                        child: Loading(
                                          indicator: BallPulseIndicator(),
                                          size: 100.0,
                                          color: Colors.teal,
                                        ),
                                      )),
                                );
                              }
                            }),


                        //NavBar(1),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}

Widget getItenaryItem(int pos, DayPlannerModel model, String city) {
  int noOfImages;
  return Expanded(
    child: Container(
        child: ListView.separated(
            padding: EdgeInsets.fromLTRB(SizeConfig.h[10], SizeConfig.v[3],
                SizeConfig.h[10], SizeConfig.v[10]),
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  width: 5,
                ),
            itemCount: model.results[0].days[pos].itineraryItems.length,
            itemBuilder: (BuildContext context, int index) {
              noOfImages = model.results[0].days[pos].itineraryItems[index].poi
                      .images.length -
                  1;
              return Padding(
                padding: EdgeInsets.fromLTRB(SizeConfig.h[20], SizeConfig.v[2],
                    SizeConfig.h[20], SizeConfig.v[2]),
                child: Container(
                  width: SizeConfig.h[330],
                  height: SizeConfig.v[300],
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      borderRadius: BorderRadius.circular(SizeConfig.f[8])),
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(SizeConfig.h[10],
                      SizeConfig.v[20], SizeConfig.h[10], SizeConfig.v[20]),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getImageURL(noOfImages, model, index, pos),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '${model.results[0].days[pos].itineraryItems[index].poi.name}',
                              style: GoogleFonts.dosis(
                                  color: Colors.white70,
                                  fontSize: SizeConfig.f[17],
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewScreen(
                                          'https://www.google.com/maps/search/?api=1&query=' +
                                              '${model.results[0].days[pos].itineraryItems[index].poi.name}' +
                                              ',' +
                                              '$city')));
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.h[10],
                                  SizeConfig.v[10],
                                  SizeConfig.h[10],
                                  SizeConfig.v[10]),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                                size: SizeConfig.f[17],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.v[3],
                      ),
                      Container(
                        height: SizeConfig.v[80],
                        child: ListView(
                          children: [
                            Text(
                                '${model.results[0].days[pos].itineraryItems[index].description}',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.dosis(
                                  color: Colors.white70,
                                  fontSize: SizeConfig.f[15],
                                  fontStyle: FontStyle.italic,
                                  //fontWeight: FontWeight.bold
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
  );
}

Widget getImageURL(int count, DayPlannerModel model, int index, int pos) {
  if (count == -1) {
    return Container(
        height: SizeConfig.v[150],
        child: img.Image(image: AssetImage('images/picnotfound.jpg')));
  } else {
    return Container(
        height: SizeConfig.v[150],
        child: img.Image(
            image: AdvancedNetworkImage(
                model.results[0].days[pos].itineraryItems[index].poi.images[0]
                    .sizes.medium.url,
                fallbackAssetImage: 'images/picnotfound.jpg')));
  }
}
