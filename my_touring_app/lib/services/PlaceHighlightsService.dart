import 'dart:ffi';

import 'package:mytouringapp/models/PlaceHighlightsModel.dart';
import 'dart:convert';

import 'package:mytouringapp/models/PlaceDetailsModel.dart';
import 'package:http/http.dart' as http;
import 'package:mytouringapp/models/PlacesToEatModel.dart';
import 'package:mytouringapp/core/MyCacheManager.dart';

class PlaceHighlightsService{

  Future<PlaceHighlightsModel> getPlaceHighlights(double latitude,double longitude) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json, text/plain, */*",
      "X-Triposo-Account":"77ZM10J6",
      "X-Triposo-Token":"fzqzif0vbebc51b6cp8uh2o9i74o2t1w",
    };

    var url =
        "https://www.triposo.com/api/20200405/local_highlights.json?latitude="+'$latitude'+"&longitude="+'$longitude';
    print('$url');
    var file = await MyCacheManager().getSingleFile(url, headers: requestHeaders);
    if (file != null && await file.exists()) {
      var res = await file.readAsString();
      return PlaceHighlightsModel.fromJson(json.decode(http.Response(res,200).body));
    }
    print('noo');
    throw Exception('unableToFetchDetails');

    /*var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      print('placeHighlight');
      return PlaceHighlightsModel.fromJson(json.decode(response.body));
    } else {
      print('noo');
      throw Exception('unableToFetchDetails');
    }*/
  }

}