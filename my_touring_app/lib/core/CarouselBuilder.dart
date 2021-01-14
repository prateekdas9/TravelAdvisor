import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:mytouringapp/models/PlaceDetailsModel.dart';
import 'package:mytouringapp/services/PlaceDetailsService.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:toggle_bar/toggle_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SizeConfig.dart';
class CarouselBuilder extends StatefulWidget {
  List<String> imageUrls=[];
  CarouselBuilder(List<String> image){
    this.imageUrls=image;
  }
  @override
  _CarouselBuilderState createState() => _CarouselBuilderState(this.imageUrls);
}

class _CarouselBuilderState extends State<CarouselBuilder> {
  List<String> imageUrls=[];
  _CarouselBuilderState(List<String> image){
    this.imageUrls=image;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
          options: CarouselOptions(
            height: SizeConfig.v[300],
            //aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            //autoPlayInterval: Duration(seconds: 3),
            //autoPlayAnimationDuration: Duration(milliseconds: 800),
           //autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            //onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          items: imageUrls.map((item) => Container(
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(SizeConfig.f[10]),
                child: img.Image.network(item, fit: BoxFit.fill,height: SizeConfig.v[300],width: SizeConfig.h[300],)),
            //color: Colors.transparent,
          )).toList(),
        )
    );
  }
}
