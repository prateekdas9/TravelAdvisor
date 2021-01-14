// To parse this JSON data, do
//
//     final placeScoreModel = placeScoreModelFromJson(jsonString);

import 'dart:convert';

PlaceScoreModel placeScoreModelFromJson(String str) => PlaceScoreModel.fromJson(json.decode(str));

String placeScoreModelToJson(PlaceScoreModel data) => json.encode(data.toJson());

class PlaceScoreModel {
  PlaceScoreModel({
    this.results,
    this.more,
    this.estimatedCount,
  });

  List<Result> results;
  bool more;
  int estimatedCount;

  factory PlaceScoreModel.fromJson(Map<String, dynamic> json) => PlaceScoreModel(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    more: json["more"],
    estimatedCount: json["estimated_count"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "more": more,
    "estimated_count": estimatedCount,
  };
}

class Result {
  Result({
    this.scores,
    this.coordinates,
  });

  List<Score> scores;
  Coordinates coordinates;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    scores: List<Score>.from(json["scores"].map((x) => Score.fromJson(x))),
    coordinates: Coordinates.fromJson(json["coordinates"]),
  );

  Map<String, dynamic> toJson() => {
    "scores": List<dynamic>.from(scores.map((x) => x.toJson())),
    "coordinates": coordinates.toJson(),
  };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Score {
  Score({
    this.tagLabel,
    this.count,
    this.score,
  });

  String tagLabel;
  int count;
  double score;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    tagLabel: json["tag_label"],
    count: json["count"],
    score: json["score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "tag_label": tagLabel,
    "count": count,
    "score": score,
  };
}
