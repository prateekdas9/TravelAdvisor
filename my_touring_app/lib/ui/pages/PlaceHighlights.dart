

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';
import 'package:mytouringapp/core/NavigationBar.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceHighlightsModel.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:mytouringapp/services/PlaceHighlightsService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:mytouringapp/core/WebViewScreen.dart';


class PlaceHighlights extends StatefulWidget {
  double latitude;
  double longitude;
  String city;
  PlaceHighlights(double latVal,double longVal,String cit) {
    this.latitude= latVal;
    this.longitude=longVal;
    this.city=cit;
  }
  @override
  _PlaceHighlightsState createState() => _PlaceHighlightsState(this.latitude,this.longitude,this.city);
}

class _PlaceHighlightsState extends State<PlaceHighlights> {
  double latitude;
  double longitude;
  String city;
  _PlaceHighlightsState(double latVal,double longVal,String cit) {
    this.latitude= latVal;
    this.longitude=longVal;
    this.city=cit;
  }
  Future<PlaceHighlightsModel> response;
  PlaceHighlightsService service = PlaceHighlightsService();
  @override
  void initState() {
    print('before place Highlight Call');
    response = service.getPlaceHighlights(latitude,longitude);
    print('here1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building in high');
    PlaceHighlightsModel values;
    SizeConfig().init(context);
    int noOfImages;
    List<String> imageUrls = [];
    return SafeArea(
      child: Container(
        decoration: BackGroundTheme.getTheme(),
        child:  Scaffold(
                  bottomNavigationBar: NavBar(4),
                  //resizeToAvoidBottomInset: true,
                  body: Column(
                    children: [
                      Container(
                        child: CustomAppBar("Local Highlights"),
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
                          itemCount: values.results[0].pois.length,
                          itemBuilder: (BuildContext context, int index) {
                            noOfImages = values.results[0].pois[index].images.length - 1;

                            return Padding(
                              padding:  EdgeInsets.fromLTRB(SizeConfig.h[20], SizeConfig.v[2], SizeConfig.h[20], SizeConfig.v[2]),
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
                                    borderRadius: BorderRadius.circular(SizeConfig.f[8])
                                ),
                                alignment: Alignment.center,
                                //color:Colors.transparent,
                                //width: SizeConfig.h[200],
                                padding: EdgeInsets.fromLTRB(SizeConfig.h[10], SizeConfig.v[20], SizeConfig.h[10], SizeConfig.v[20]),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getImageURL(noOfImages, values, index),
                                    Text('${values.results[0].pois[index].name}',
                                        style: GoogleFonts.dosis(
                                            color: Colors.white70,
                                            fontSize: SizeConfig.f[20],
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold)),
                                    Text('${values.results[0].pois[index].snippet}',
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
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  '${values.results[0].pois[index].score.ceilToDouble()}',
                                                  style: GoogleFonts.dosis(
                                                      color: Colors.white,
                                                      fontSize: SizeConfig.f[15],
                                                      fontStyle: FontStyle.italic),
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
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Tag Name',
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
                                            Text('${getTagName(values, values.results[0].pois[index].id)}',
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context)=>WebViewScreen('https://www.google.com/maps/search/?api=1&query='+'${values.results[0].pois[index].name}'+','+'$city')
                                                )
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Click to Follow in Google Map',
                                                      //'${values.results[index].coordinates.longitude}'+', '+'${values.results[index].coordinates.latitude}',
                                                      style: GoogleFonts.barlow(
                                                          color: Colors.blueAccent,
                                                          fontSize: SizeConfig.f[15],
                                                          fontStyle: FontStyle.italic),
                                                    ),
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.blueAccent,
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
                          separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            height: 5,
                          ),
                        )),
                  );
                }
                else{
                  return Expanded(
                    child: Container(
                        child:Center(
                          //child: CupertinoActivityIndicator(),
                          child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.teal,),
                        )
                    ),
                  );
                }
              }

              ),

                     // NavBar(4),
                    ],
                  ),
                )

      ),
    );
  }
}

Widget listItem(BuildContext context) {
  return Container();
}

Widget getImageURL(int count, PlaceHighlightsModel model, int index) {
  if (count == -1) {
    return Container(
        height: SizeConfig.v[200],
        child: img.Image(image: AssetImage('images/picnotfound.jpg')));
  } else {
    return Container(
        height: SizeConfig.v[200],
        child: img.Image(
            image: AdvancedNetworkImage(
                model.results[0].pois[index].images[0].sizes.medium.url,
                fallbackAssetImage: 'images/picnotfound.jpg')));
  }
}


String getTagName(PlaceHighlightsModel model, String id){
  String tagName="";
  bool found=false;
  for(int i =0;i<model.results[0].poiDivision.length;i++){
          for(int j=0;j<model.results[0].poiDivision[i].poiIds.length;j++){
            if (id==model.results[0].poiDivision[i].poiIds[j]){
              tagName=model.results[0].poiDivision[i].tagName;
              found=true;
              break;
            }
          }
          if(found==true){
            break;
          }
  }
  return tagName;

}