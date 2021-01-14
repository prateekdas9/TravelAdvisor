import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytouringapp/ui/pages/DayPlanner.dart';
import 'package:mytouringapp/ui/pages/PlaceDetails.dart';
import 'package:mytouringapp/ui/pages/PlaceHighlights.dart';
import 'package:mytouringapp/ui/pages/PlaceScore.dart';
import 'package:mytouringapp/ui/pages/PlacesToEat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SizeConfig.dart';

class NavBar extends StatefulWidget {
  int reqScreen;
  NavBar(int req){
    this.reqScreen=req;
  }
  @override
  _NavBarState createState() => _NavBarState(this.reqScreen);
}

class _NavBarState extends State<NavBar> {
  int reqScreen;
  SharedPreferences sp;
  String id;
  String name;
  double latitude;
  double longitude;
  _NavBarState(int req){
    this.reqScreen=req;
  }
  @override
  void initState() {
    getSharedPref();

    super.initState();
  }

  getSharedPref() async{
    sp=await SharedPreferences.getInstance();
    setState(() {
      id = sp.getString('id');
      name = sp.getString('name');
      latitude=sp.getDouble('latitude');
      longitude=sp.getDouble('longitude');
    });
  }

  int getSizeIcon(int flag){
    if(flag==reqScreen){
      return 30;
    }
    else{
      return 28;
    }
  }

  int getSizeText(int flag){
    if(flag==reqScreen){
      return 16;
    }
    else{
      return 16;
    }
  }

  Color getColor(int flag){
    if(flag==reqScreen){
      return Colors.teal;
    }
    else{
      return Colors.white70;
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.h[60],
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
            /*colors:[Colors.red,
            Colors.black]*/
          ),
        ),

        padding: EdgeInsets.fromLTRB(
            SizeConfig.h[15], SizeConfig.v[1],
            SizeConfig.h[15], SizeConfig.v[1]),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if(reqScreen!=1) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        DayPlanner(id)
                )
                );
              }
            },
            child: Column(
              children: [
                Icon(
                  Icons.settings_system_daydream,
                  color: getColor(1),
                  size: SizeConfig.f[getSizeIcon(1)],
                ),
                Text('Day Planner',
                  style: GoogleFonts.barlow(
                      color: getColor(1),
                      fontSize: SizeConfig.f[getSizeText(1)]
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if(reqScreen!=2) {
                var values;
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PlacesToEat(id)
                )
                );
              }
            },
            child: Column(
              children: [
                Icon(
                  Icons.fastfood,
                  color: getColor(2),
                  size: SizeConfig.f[getSizeIcon(2)],
                ),
                Text('Food',
                  style: GoogleFonts.barlow(
                      color: getColor(2),
                      fontSize: SizeConfig.f[getSizeText(2)]
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                if(reqScreen!=3) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PlaceDetails(id: id)
                  )
                  );
                }
              });
            },
            child: Column(
              children: [
                Icon(
                  Icons.details,
                  color: getColor(3),
                  size: SizeConfig.f[getSizeIcon(3)],
                ),
                Text('Details',
                  style: GoogleFonts.barlow(
                      color: getColor(3),
                      fontSize: SizeConfig.f[getSizeText(3)]
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if(reqScreen!=4) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PlaceHighlights(
                            latitude,
                            longitude,
                            name)
                )
                );
              }
            },
            child: Column(
              children: [
                Icon(
                  Icons.label_important,
                  color: getColor(4),
                  size: SizeConfig.f[getSizeIcon(4)],
                ),
                Text('Highlights',
                  style: GoogleFonts.barlow(
                      color: getColor(4),
                      fontSize: SizeConfig.f[getSizeText(4)]

                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if(reqScreen!=5) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PlaceScore(
                            latitude,
                            longitude)
                )
                );
              }
            },
            child: Column(
              children: [
                Icon(
                  Icons.score,
                  color: getColor(5),
                  size: SizeConfig.f[getSizeIcon(5)],
                ),
                Text('Scores',
                  style: GoogleFonts.barlow(
                      color: getColor(5),
                      fontSize: SizeConfig.f[getSizeText(5)]
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }


}
