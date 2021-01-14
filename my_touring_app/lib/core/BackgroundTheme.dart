import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/core/WebViewScreen.dart';
import 'package:mytouringapp/ui/pages/PlaceDetails.dart';

class BackGroundTheme{

 static BoxDecoration getTheme(){
    return BoxDecoration(
      image: new DecorationImage(
        //image: new AssetImage("images/background1.jpg",),
          image: new AssetImage("images/appbg.jpg",),


        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
        fit: BoxFit.fill,
      ),
    );
  }
}