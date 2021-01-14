import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceDetailsModel.dart';
import 'package:mytouringapp/services/PlaceDetailsService.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:mytouringapp/core/WebViewScreen.dart';
import 'package:mytouringapp/ui/pages/DayPlanner.dart';
import 'package:mytouringapp/ui/pages/PlaceHighlights.dart';
import 'package:mytouringapp/ui/pages/PlaceScore.dart';
import 'package:mytouringapp/ui/pages/PlacesToEat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_bar/toggle_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class PlaceDetails extends StatefulWidget {
  Future<PlaceDetailModel> model;
  String screen;
  String id;
  PlaceDetails({this.model,this.screen,this.id}){}
  @override
  _PlaceDetailsState createState() => _PlaceDetailsState(this.model,this.screen,this.id);
}

class _PlaceDetailsState extends State<PlaceDetails> {
  SharedPreferences sp;
  Future<PlaceDetailModel> model;
  String screen;
  String id;
  _PlaceDetailsState(Future<PlaceDetailModel> val,String s,String i){
    this.model=val;
    this.screen=s;
    this.id=i;
  }
  Future<PlaceDetailModel> response;
  PlaceDetailsService service=PlaceDetailsService() ;
  @override
  void initState() {
    if(screen=='home') {
      response = model;
      setSharedPref();
    }
    else{
      response = service.getPlaceDetails(id);
    }
      //response = service.getPlaceDetails(city);
      print('here1');
    super.initState();
  }
  setSharedPref() async{
    sp=await SharedPreferences.getInstance();

  }
  setSharedPrefAttribute(PlaceDetailModel values){
    if(screen=='home'){
      sp.setString('id', values.results[0].id);
      sp.setString('name', values.results[0].name);
      sp.setDouble('latitude', values.results[0].coordinates.latitude);
      sp.setDouble('longitude', values.results[0].coordinates.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building');
    PlaceDetailModel values;
    List<String> list = [];
    SizeConfig().init(context);
    return
    SafeArea(
      child: Container(
        decoration: BackGroundTheme.getTheme(),
        child: FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.hasData ) {
                values = snapshot.data;
                setSharedPrefAttribute(values);
                if(values.results.length>0) {
                  for (int i = 0; i < values.results[0].images.length; i++) {
                    list.add(values.results[0].images[i].sourceUrl);
                  }
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(

                            child: CustomAppBar('Explore ' + '${values
                                .results[0].name}')

                        ),

                        Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: SizeConfig.v[400],
                                //aspectRatio: 16/9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(
                                    milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                //onPageChanged: callbackFunction,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: list.map((item) =>
                                  Container(
                                    child:
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.f[10]),
                                        child: img.Image.network(
                                          item, fit: BoxFit.fill,
                                          height: SizeConfig.v[400],
                                          width: SizeConfig.h[400],)),
                                    //color: Colors.transparent,
                                  )).toList(),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              SizeConfig.h[15], SizeConfig.v[4],
                              SizeConfig.h[15], SizeConfig.v[4]),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  //backgroundBlendMode: BlendMode.softLight,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.f[8])
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.h[15], SizeConfig.v[10],
                                  SizeConfig.h[15], SizeConfig.v[15]),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${values.results[0].name}',
                                    style: GoogleFonts.dosis(
                                        color: Colors.white70,
                                        fontSize: SizeConfig.f[20],
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  Text('${values.results[0].countryId}',
                                    style: GoogleFonts.dosis(
                                        color: Colors.blueGrey,
                                        fontSize: SizeConfig.f[15],
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.v[15],
                                  ),
                                  Container(
                                    height: SizeConfig.v[70],
                                    child: ListView(
                                      children: [
                                        Text('${values.results[0].snippet}',
                                          style: GoogleFonts.dosis(
                                              color: Colors.white70,
                                              fontSize: SizeConfig.f[15],
                                              fontStyle: FontStyle.italic
                                          ),),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: SizeConfig.v[10],
                                  ),
                                  Text('Location',
                                    style: GoogleFonts.dosis(
                                      color: Colors.blueGrey,
                                      fontSize: SizeConfig.f[12],
                                      fontWeight: FontWeight.bold,
                                      //fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.v[5],
                                  ),
                                  //Text('https://www.openstreetmap.org/search?query='+'${values.results[0].coordinates.longitude}'+', '+'${values.results[0].coordinates.latitude}',
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              WebViewScreen(
                                                  'https://www.openstreetmap.org/search?query=' +
                                                      '${values.results[0]
                                                          .name}')
                                      )
                                      );
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text('Click to open Street Maps',
                                            style: GoogleFonts.dosis(
                                                color: Colors.blueAccent,
                                                fontSize: SizeConfig.f[15],
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.h[10],
                                          ),
                                          Icon(
                                            Icons.streetview,
                                            size: SizeConfig.f[15],
                                            color: Colors.blueAccent,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.v[20],
                                  ),
                                  Text('Location Score',
                                    style: GoogleFonts.dosis(
                                      color: Colors.blueGrey,
                                      fontSize: SizeConfig.f[12],
                                      fontWeight: FontWeight.bold,
                                      //fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.v[5],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                    ),

                                    padding: EdgeInsets.fromLTRB(
                                        SizeConfig.h[10], SizeConfig.v[5],
                                        SizeConfig.h[10], SizeConfig.v[5]),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${values.results[0].score.ceil()}',
                                          style: GoogleFonts.dosis(
                                              color: Colors.white,
                                              fontSize: SizeConfig.f[15],
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: SizeConfig.h[15],
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Color.fromRGBO(0, 0, 0, 0.4),
                                  Color.fromRGBO(0, 0, 0, 0.4),
                                  Colors.transparent
                                ]
                              //color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),

                          padding: EdgeInsets.fromLTRB(
                              SizeConfig.h[15], SizeConfig.v[10],
                              SizeConfig.h[15], SizeConfig.v[10]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          DayPlanner(values.results[0].id)
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.settings_system_daydream,
                                      color: Colors.white70,
                                      size: SizeConfig.f[28],
                                    ),
                                    Text('Day Planner',
                                      style: GoogleFonts.barlow(
                                          color: Colors.white70,
                                          fontSize: SizeConfig.f[16]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          PlacesToEat(values.results[0].id)
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.fastfood,
                                      color: Colors.white70,
                                      size: SizeConfig.f[28],
                                    ),
                                    Text('Food',
                                      style: GoogleFonts.barlow(
                                          color: Colors.white70,
                                          fontSize: SizeConfig.f[16]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {

                                  });
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.details,
                                      color: Colors.teal,
                                      size: SizeConfig.f[28],
                                    ),
                                    Text('Details',
                                      style: GoogleFonts.barlow(
                                          color: Colors.teal,
                                          fontSize: SizeConfig.f[16]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          PlaceHighlights(
                                              values.results[0].coordinates
                                                  .latitude,
                                              values.results[0].coordinates
                                                  .longitude,
                                              values.results[0].name)
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.label_important,
                                      color: Colors.white70,
                                      size: SizeConfig.f[28],
                                    ),
                                    Text('Highlights',
                                      style: GoogleFonts.barlow(
                                          color: Colors.white70,
                                          fontSize: SizeConfig.f[16]

                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          PlaceScore(
                                              values.results[0].coordinates
                                                  .latitude,
                                              values.results[0].coordinates
                                                  .longitude)
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.score,
                                      color: Colors.white70,
                                      size: SizeConfig.f[28],
                                    ),
                                    Text('Scores',
                                      style: GoogleFonts.barlow(
                                          color: Colors.white70,
                                          fontSize: SizeConfig.f[16]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                else{
                  //Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.pop(context);
                  });
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        CustomAppBar(''),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                    'Cannot Find Result',
                                  style: GoogleFonts.josefinSans(
                                    fontSize: SizeConfig.f[30],
                                    color: Colors.white70
                                  ),
                                  ),
                              ),
                              Center(
                                child: Text(
                                  'Navigating back to the previous Screen',
                                  style: GoogleFonts.josefinSans(
                                      fontSize: SizeConfig.f[15],
                                      color: Colors.white70
                                  ),
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
              else{
                return Container(
                  child:Center(
                    //child: CupertinoActivityIndicator(),
                    child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.teal,),
                  )
                );
              }
            }
        ),
      ),
    );


  }
}


