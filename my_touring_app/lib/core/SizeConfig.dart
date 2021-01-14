import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double textScalingFactor;
  static List<double> h;
  static List<double> v;
  static List<double> f;



  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;
    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;
    setwid();
    textScalingFactor=_mediaQueryData.textScaleFactor;


  }

  void setwid(){
    print('$safeBlockVertical');
    print('$safeBlockHorizontal');
    List<double> hor=new List<double>(901);
    List<double> ver=new List<double>(901);
    List<double> font=new List<double>(901);
       for(int i=1;i<901;i++){
      ver[i]=safeBlockVertical*(i/8.96);
      hor[i]=safeBlockHorizontal*(i/4.14);
      font[i]=(i/2)*((safeBlockVertical/8.96)+(safeBlockHorizontal/4.14));
    }
    h=hor;
       v=ver;
       f=font;
  }
}