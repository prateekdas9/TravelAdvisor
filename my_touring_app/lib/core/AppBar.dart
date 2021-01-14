import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceDetailsModel.dart';
import 'package:mytouringapp/services/PlaceDetailsService.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:mytouringapp/ui/pages/HomePage.dart';
import 'package:toggle_bar/toggle_bar.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomAppBar extends StatefulWidget {
  String value;
  CustomAppBar( String name){
    this.value=name;
  }
  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.value);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String value;
  _CustomAppBarState(String name){
    this.value=name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black,Colors.transparent]
        ),

      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: SizeConfig.f[25],
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text('${value}',
                style:GoogleFonts.quicksand(
                    color:Colors.white70,
                    fontSize: SizeConfig.f[25],
                    fontWeight: FontWeight.bold
                  //fontStyle: FontStyle.italic
                )),
          ),
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: SizeConfig.f[25],
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>HomePage()
              )
              );
            },
          ),
        ],
      ),
    );
  }
}
