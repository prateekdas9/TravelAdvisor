// To parse this JSON data, do
//
//     final placeToEatModel = placeToEatModelFromJson(jsonString);

import 'dart:convert';

PlacesToEatModel placeToEatModelFromJson(String str) => PlacesToEatModel.fromJson(json.decode(str));

String placeToEatModelToJson(PlacesToEatModel data) => json.encode(data.toJson());

class PlacesToEatModel {
  PlacesToEatModel({
    this.results,
    this.more,
  });

  List<Result> results;
  bool more;

  factory PlacesToEatModel.fromJson(Map<String, dynamic> json) => PlacesToEatModel(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    more: json["more"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "more": more,
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.coordinates,
    this.score,
    this.images,
    this.bookingInfo,
    this.attribution,
    this.priceTier,
    this.snippetLanguageInfo,
    this.snippet,
    this.locationId,
    this.eatingoutScore,
  });

  String id;
  String name;
  Coordinates coordinates;
  double score;
  List<Image> images;
  dynamic bookingInfo;
  List<AttributionElement> attribution;
  int priceTier;
  dynamic snippetLanguageInfo;
  String snippet;
  LocationId locationId;
  double eatingoutScore;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    score: json["score"].toDouble(),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    bookingInfo: json["booking_info"],
    attribution: List<AttributionElement>.from(json["attribution"].map((x) => AttributionElement.fromJson(x))),
    priceTier: json["price_tier"] == null ? null : json["price_tier"],
    snippetLanguageInfo: json["snippet_language_info"],
    snippet: json["snippet"],
    locationId: locationIdValues.map[json["location_id"]],
    eatingoutScore: json["eatingout_score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coordinates": coordinates.toJson(),
    "score": score,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "booking_info": bookingInfo,
    "attribution": List<dynamic>.from(attribution.map((x) => x.toJson())),
    "price_tier": priceTier == null ? null : priceTier,
    "snippet_language_info": snippetLanguageInfo,
    "snippet": snippet,
    "location_id": locationIdValues.reverse[locationId],
    "eatingout_score": eatingoutScore,
  };
}

class AttributionElement {
  AttributionElement({
    this.sourceId,
    this.url,
  });

  SourceId sourceId;
  String url;

  factory AttributionElement.fromJson(Map<String, dynamic> json) => AttributionElement(
    sourceId: sourceIdValues.map[json["source_id"]],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceIdValues.reverse[sourceId],
    "url": url,
  };
}

enum SourceId { FACEBOOK, OPENSTREETMAP, WIKIVOYAGE }

final sourceIdValues = EnumValues({
  "facebook": SourceId.FACEBOOK,
  "openstreetmap": SourceId.OPENSTREETMAP,
  "wikivoyage": SourceId.WIKIVOYAGE
});

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

class Image {
  Image({
    this.sourceId,
    this.sourceUrl,
    this.owner,
    this.ownerUrl,
    this.license,
    this.caption,
    this.attribution,
    this.sizes,
  });

  String sourceId;
  String sourceUrl;
  String owner;
  String ownerUrl;
  String license;
  dynamic caption;
  ImageAttribution attribution;
  Sizes sizes;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    sourceId: json["source_id"],
    sourceUrl: json["source_url"],
    owner: json["owner"],
    ownerUrl: json["owner_url"],
    license: json["license"] == null ? null : json["license"],
    caption: json["caption"],
    attribution: ImageAttribution.fromJson(json["attribution"]),
    sizes: Sizes.fromJson(json["sizes"]),
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceId,
    "source_url": sourceUrl,
    "owner": owner,
    "owner_url": ownerUrl,
    "license": license == null ? null : license,
    "caption": caption,
    "attribution": attribution.toJson(),
    "sizes": sizes.toJson(),
  };
}

class ImageAttribution {
  ImageAttribution({
    this.format,
    this.attributionText,
    this.attributionLink,
    this.licenseText,
    this.licenseLink,
  });

  String format;
  String attributionText;
  String attributionLink;
  String licenseText;
  String licenseLink;

  factory ImageAttribution.fromJson(Map<String, dynamic> json) => ImageAttribution(
    format: json["format"],
    attributionText: json["attribution_text"],
    attributionLink: json["attribution_link"],
    licenseText: json["license_text"] == null ? null : json["license_text"],
    licenseLink: json["license_link"] == null ? null : json["license_link"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "attribution_text": attributionText,
    "attribution_link": attributionLink,
    "license_text": licenseText == null ? null : licenseText,
    "license_link": licenseLink == null ? null : licenseLink,
  };
}

class Sizes {
  Sizes({
    this.original,
    this.medium,
    this.thumbnail,
  });

  Medium original;
  Medium medium;
  Medium thumbnail;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
    original: Medium.fromJson(json["original"]),
    medium: Medium.fromJson(json["medium"]),
    thumbnail: Medium.fromJson(json["thumbnail"]),
  );

  Map<String, dynamic> toJson() => {
    "original": original.toJson(),
    "medium": medium.toJson(),
    "thumbnail": thumbnail.toJson(),
  };
}

class Medium {
  Medium({
    this.url,
    this.width,
    this.height,
    this.bytes,
    this.format,
  });

  String url;
  int width;
  int height;
  int bytes;
  Format format;

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    bytes: json["bytes"],
    format: formatValues.map[json["format"]],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "bytes": bytes,
    "format": formatValues.reverse[format],
  };
}

enum Format { JPG }

final formatValues = EnumValues({
  "jpg": Format.JPG
});

enum LocationId { BANGALORE }

final locationIdValues = EnumValues({
  "Bangalore": LocationId.BANGALORE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
