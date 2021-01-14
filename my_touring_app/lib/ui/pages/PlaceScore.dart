import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';
import 'package:mytouringapp/core/NavigationBar.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceScoreModel.dart';
import 'package:mytouringapp/services/PlaceScoreService.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceScore extends StatefulWidget {
  double latitude;
  double longitude;
  PlaceScore(double latVal, double longVal) {
    this.latitude = latVal;
    this.longitude = longVal;
  }
  @override
  _PlaceScoreState createState() =>
      _PlaceScoreState(this.latitude, this.longitude);
}

class _PlaceScoreState extends State<PlaceScore> {
  double latitude;
  double longitude;
  _PlaceScoreState(double latVal, double longVal) {
    this.latitude = latVal;
    this.longitude = longVal;
  }
  Future<PlaceScoreModel> response;
  PlaceScoreService service = PlaceScoreService();
  @override
  void initState() {
    response = service.getScores(latitude, longitude);
    print('here1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Building');
    PlaceScoreModel values;
    List<String> list = [];
    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        decoration: BackGroundTheme.getTheme(),
        child: Scaffold(
          bottomNavigationBar: NavBar(5),
          body: Container(
            child: Column(
              children: [
                CustomAppBar("Ratings"),
                SizedBox(
                  height: SizeConfig.v[80],
                ),

                FutureBuilder(
                    future: response,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        values = snapshot.data;
                        return getGrid(values);
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

                //NavBar(5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getitem(PlaceScoreModel model, int index) {
  print('in widget');
  String imageName =
      "images/" + model.results[0].scores[index].tagLabel + ".jpg";
  return Padding(
    padding: EdgeInsets.fromLTRB(
        SizeConfig.h[8], SizeConfig.v[8], SizeConfig.h[8], SizeConfig.v[8]),
    child: Container(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.h[5], SizeConfig.v[5], SizeConfig.h[5], SizeConfig.v[5]),
        //height:450 ,
        //width: 180,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.f[10]),
          image: new DecorationImage(
            image: new AssetImage(imageName),
            //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.results[0].scores[index].tagLabel}',
                style: GoogleFonts.dosis(
                    color: Colors.white,
                    fontSize: SizeConfig.f[20],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.5))),
            SizedBox(
              height: SizeConfig.v[5],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.results[0].scores[index].score.ceilToDouble()}',
                  style: GoogleFonts.dosis(
                      color: Colors.white,
                      fontSize: SizeConfig.f[15],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                  size: SizeConfig.h[15],
                )
              ],
            ),
          ],
        )),
  );
}

Widget getGrid(PlaceScoreModel model) {
  return Expanded(
    child: GridView.count(
      //shrinkWrap: true,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(model.results[0].scores.length, (index) {
        return getitem(model, index);
      }),
    ),
  );
}
