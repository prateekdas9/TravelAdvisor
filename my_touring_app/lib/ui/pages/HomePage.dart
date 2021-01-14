import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytouringapp/core/BackgroundTheme.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceDetailsModel.dart';
import 'package:mytouringapp/services/PlaceDetailsService.dart';
import 'package:mytouringapp/core/WebViewScreen.dart';
import 'package:mytouringapp/ui/pages/PlaceDetails.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flushbar/flushbar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  String placeName="";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  void showFlushBar(){
    print('flsush');
    Flushbar(
      title: "Place Not Found",
      message: "Kindly check for the place Name",
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      blockBackgroundInteraction: true,
      routeBlur:1.0,
      routeColor: Colors.black.withOpacity(0.4),
      isDismissible: true,
      backgroundGradient: null,
      backgroundColor: Colors.teal,
      //showProgressIndicator: true,
      icon: Icon(
        Icons.error,
        size: 28.0,
        color: Colors.blue[300],
      ),
    )..show(context);
  }
  @override
  Widget build(BuildContext context) {
    print('5');
    SizeConfig().init(context);
    //final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Container(
        //color: Colors.purple,
        decoration: BackGroundTheme.getTheme(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
            body:SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  //decoration: BackGroundTheme.getTheme(),
                  child:Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: SizeConfig.v[100],
                      ),
                      img.Image(
                        height: SizeConfig.v[200],
                        //width: SizeConfig.h[100],
                        image: AssetImage("images/logo.png"),
                      ),
                      SizedBox(
                        height: SizeConfig.v[70],
                      ),
                      Container(
                        //color:Colors.amberAccent,
                        padding: EdgeInsets.fromLTRB(SizeConfig.h[20], SizeConfig.v[1], SizeConfig.h[20], SizeConfig.v[10]),
                        //height: 400,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height:SizeConfig.v[90],
                                width: SizeConfig.h[350],
                                child: TextFormField(
                                  style:TextStyle(color: Colors.white70,fontSize: SizeConfig.f[20]),
                                  decoration:  InputDecoration(
                                    icon: Icon(Icons.location_city,color: Colors.teal,),
                                    hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: SizeConfig.f[14]
                                    ),
                                    counterText: 'Explore Cities',
                                    counterStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: SizeConfig.f[14]
                                    ),
                                    prefixIcon: Icon(Icons.search,color: Colors.white70,),
                                    hintText: 'Search for a City Name',
                                    labelText: 'City',
                                    labelStyle: TextStyle(
                                      color: Colors.white70,
                                      fontSize: SizeConfig.f[20]
                                      //fontWeight: FontWeight.bold
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:Colors.blueGrey
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white70
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white70
                                        )
                                    ),
                                  ),
                                  cursorColor: Colors.blue,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    setState(() {
                                      placeName=getPlaceName(value);
                                    });
                                  },

                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.v[50],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(SizeConfig.h[30], SizeConfig.v[25], SizeConfig.h[1], SizeConfig.v[15]),
                                child: ButtonTheme(
                                  height: SizeConfig.v[40],
                                  minWidth: SizeConfig.h[200],
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    textTheme: ButtonTextTheme.primary,
                                    color: Colors.amber,
                                    onPressed: () {

                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        print('$placeName');
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black.withOpacity(0.4),
                                            behavior: SnackBarBehavior.floating,

                                            //duration: Duration(seconds: 4),
                                            content: Row(
                                              children: [
                                                CupertinoActivityIndicator(
                                                  animating: true,
                                                ),
                                                SizedBox(width: SizeConfig.h[10],),
                                                Text("Fetching Results",
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: SizeConfig.f[20],
                                                  color: Colors.white70
                                                ),),
                                              ],
                                            ),
                                          )
                                        );
                                        Future<PlaceDetailModel> model=getDetails(placeName);
                                        model.then((value) {
                                          _scaffoldKey.currentState.hideCurrentSnackBar();
                                          if(value.results.length!=0){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>PlaceDetails(model:model,screen:'home')
                                            )
                                            );
                                          }
                                          else{
                                            print('HI');
                                            showFlushBar();
                                          }
                                        });
                                       /* Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>PlaceDetails('$placeName')
                                        )
                                        );*/
                                      }
                                    },
                                    child: Text('Explore'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.v[160],
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(SizeConfig.h[25], SizeConfig.v[10], SizeConfig.h[25], SizeConfig.v[10]),
                                  alignment: Alignment.centerLeft,
                                  //color: Colors.red,
                                  child:Text(
                                    'Want to Book a flight or a Perfect Holiday stay?\nDont Worry!! We got you covered',
                                    style: GoogleFonts.josefinSans(
                                        color: Colors.white70,
                                        fontSize: SizeConfig.f[15],
                                        fontStyle: FontStyle.italic
                                    ),
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(SizeConfig.h[40], 0, SizeConfig.h[25], 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.blueGrey,
                                      ),
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      //backgroundBlendMode: BlendMode.softLight,
                                      borderRadius: BorderRadius.circular(SizeConfig.f[8])
                                  ),
                                  //color: Colors.red,
                                  padding: EdgeInsets.fromLTRB(SizeConfig.h[10], SizeConfig.v[5], SizeConfig.h[10], SizeConfig.v[5]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewScreen("https://www.makemytrip.com/")
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: SizeConfig.h[50],
                                          height: SizeConfig.v[20],
                                          child: img.Image(
                                            fit: BoxFit.fill,
                                            image:AssetImage(
                                                'images/mmt.png'
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewScreen("https://www.oyorooms.com/")
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: SizeConfig.h[50],
                                          height: SizeConfig.v[20],
                                          child: img.Image(
                                            image:AssetImage(
                                                'images/oyologo.png'
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewScreen("https://www.booking.com/")
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: SizeConfig.h[50],
                                          height: SizeConfig.v[20],
                                          child: img.Image(
                                            fit: BoxFit.fill,
                                            image:AssetImage(
                                                'images/booking.com.png'
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewScreen("https://www.trivago.in/")
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: SizeConfig.h[50],
                                          height: SizeConfig.v[20],
                                          child: img.Image(
                                            //fit: BoxFit.fill,
                                            image:AssetImage(
                                                'images/trivagoff.png'
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>WebViewScreen("https://www.airbnb.com/")
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: SizeConfig.h[50],
                                          height: SizeConfig.v[20],
                                          child: img.Image(
                                            image:AssetImage(
                                                'images/airbnb.jpg'
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ),
            )
          //body:PlaceScore(35.6802544,139.75606925168603)
          //body:DayPlanner("London")
          //body:PlaceHighlights(35.6802544,139.75606925168603,'Tokyo')
          //body: PlaceDetails("Berlin"),
          //body: PlacesToEat('London'),
        ),
      ),
    );



  }
}

String getPlaceName(String value){

  String formattedVal="";

  for(int i=0;i<value.length;i++){
      if(i==0){
        formattedVal+=value[i].toUpperCase();
      }
      else if(value[i]==" "){
        formattedVal+="_";
      }
      else if(value[i-1]==" "){
        formattedVal+=value[i].toUpperCase();
      }
      else{
        formattedVal+=value[i].toLowerCase();
      }
  }
  return formattedVal;
}

Future<PlaceDetailModel> getDetails(String name) async{
  PlaceDetailsService service=PlaceDetailsService();
  PlaceDetailModel response=await service.getPlaceDetails(name);
  return response;
}

