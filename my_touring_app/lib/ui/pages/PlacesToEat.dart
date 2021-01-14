import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';

import 'package:mytouringapp/core/NavigationBar.dart';
import 'package:mytouringapp/core/SizeConfig.dart';

import 'package:mytouringapp/models/PlacesToEatModel.dart';

import 'package:flutter/src/widgets/image.dart' as img;
import 'package:mytouringapp/services/PlacesToEatService.dart';
import 'package:mytouringapp/core/WebViewScreen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_networkimage/provider.dart';


class PlacesToEat extends StatefulWidget {
  String city;
  PlacesToEat(String id) {
    this.city = id;
  }
  @override
  _PlacesToEatState createState() => _PlacesToEatState(this.city);
}

class _PlacesToEatState extends State<PlacesToEat> {
  String city;
  _PlacesToEatState(String id) {
    this.city = id;
  }
  Future<PlacesToEatModel> response;
  PlacesToEatService service = PlacesToEatService();
  @override
  void initState() {
    response = service.getPlacesToEat(city);
    print('here1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlacesToEatModel values;
    SizeConfig().init(context);
    int noOfImages;
    List<String> imageUrls = [];
    return SafeArea(
      child: Container(
        decoration: BackGroundTheme.getTheme(),
        child:  Scaffold(
                  bottomNavigationBar: NavBar(2),
                  body: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CustomAppBar("Dine Out"),
                      ),
                      FutureBuilder(
                          future: response,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              values = snapshot.data;
                              return Expanded(
                                child: Container(
                                    //height: SizeConfig.v[770],
                                    color: Colors.transparent,
                                    child: ListView.separated(
                                      padding: EdgeInsets.all(10),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: values.results.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        noOfImages =
                                            values.results[index].images.length - 1;

                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.h[20],
                                              SizeConfig.v[2],
                                              SizeConfig.h[20],
                                              SizeConfig.v[2]),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                                //color:Color(0xffe6e6e6),
                                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                                //color: Colors.black,
                                                //backgroundBlendMode: BlendMode,
                                                borderRadius: BorderRadius.circular(
                                                    SizeConfig.f[8])),
                                            alignment: Alignment.center,
                                            //color:Colors.transparent,
                                            //width: SizeConfig.h[200],
                                            padding: EdgeInsets.fromLTRB(
                                                SizeConfig.h[10],
                                                SizeConfig.v[20],
                                                SizeConfig.h[10],
                                                SizeConfig.v[20]),
                                            child: Column(
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                getImageURL(noOfImages, values, index),
                                                Text('${values.results[index].name}',
                                                    style: GoogleFonts.dosis(
                                                        color: Colors.white70,
                                                        fontSize: SizeConfig.f[20],
                                                        fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.bold)),
                                                Text('${values.results[index].snippet}',
                                                    style: GoogleFonts.dosis(
                                                      color: Colors.white70,
                                                      fontSize: SizeConfig.f[15],
                                                      fontStyle: FontStyle.italic,
                                                      //fontWeight: FontWeight.bold
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig.v[10],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Eating-Out Score',
                                                          style: GoogleFonts.dosis(
                                                            color: Colors.blueGrey,
                                                            fontSize: SizeConfig.f[12],
                                                            fontWeight: FontWeight.bold,
                                                            //fontStyle: FontStyle.italic
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig.v[3],
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              '${values.results[index].eatingoutScore.ceilToDouble()}',
                                                              style: GoogleFonts.dosis(
                                                                  color: Colors.white,
                                                                  fontSize:
                                                                  SizeConfig.f[15],
                                                                  fontStyle:
                                                                  FontStyle.italic),
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                              size: SizeConfig.h[15],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig.h[25],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Price Tier',
                                                          style: GoogleFonts.dosis(
                                                            color: Colors.blueGrey,
                                                            fontSize: SizeConfig.f[12],
                                                            fontWeight: FontWeight.bold,
                                                            //fontStyle: FontStyle.italic
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig.v[3],
                                                        ),
                                                        Text(
                                                            '${values.results[index].priceTier}',
                                                            style: GoogleFonts.dosis(
                                                              color: Colors.white70,
                                                              fontSize: SizeConfig.f[15],
                                                              fontStyle: FontStyle.italic,
                                                              //fontWeight: FontWeight.bold
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.v[5],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Row(children: [
                                                          Text(
                                                            'Location',
                                                            style: GoogleFonts.dosis(
                                                              color: Colors.blueGrey,
                                                              fontSize: SizeConfig.f[12],
                                                              fontWeight: FontWeight.bold,
                                                              //fontStyle: FontStyle.italic
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Icon(
                                                            Icons.my_location,
                                                            color: Colors.blueAccent,
                                                            size: SizeConfig.h[12],
                                                          )
                                                        ]),
                                                        SizedBox(
                                                          height: SizeConfig.v[3],
                                                        ),
                                                        GestureDetector(
                                                          behavior: HitTestBehavior.opaque,
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        WebViewScreen(
                                                                            'https://www.google.com/maps/search/?api=1&query=' +
                                                                                '${values.results[index].name}' +
                                                                                ',' +
                                                                                '$city')));
                                                          },
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  'Click to Follow in Google Map',
                                                                  //'${values.results[index].coordinates.longitude}'+', '+'${values.results[index].coordinates.latitude}',
                                                                  style:
                                                                  GoogleFonts.barlow(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      fontSize:
                                                                      SizeConfig
                                                                          .f[15],
                                                                      fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                                ),
                                                                Icon(
                                                                  Icons.location_on,
                                                                  color:
                                                                  Colors.blueAccent,
                                                                  size: SizeConfig.h[12],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig.h[25],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                      const Divider(
                                        height: 5,
                                      ),
                                    )),
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


                      //NavBar(2)
                    ],
                  ),
                ),
      ),
    );
  }
}

Widget listItem(BuildContext context) {
  return Container();
}

Widget getImageURL(int count, PlacesToEatModel model, int index) {
  if (count == -1) {
    return Container(
        height: SizeConfig.v[200],
        child: img.Image(image: AssetImage('images/picnotfound.jpg')));
  } else {
    return Container(
        height: SizeConfig.v[200],
        child: img.Image(
            image: AdvancedNetworkImage(
                model.results[index].images[0].sizes.medium.url,
                fallbackAssetImage: 'images/picnotfound.jpg')));
  }
}
