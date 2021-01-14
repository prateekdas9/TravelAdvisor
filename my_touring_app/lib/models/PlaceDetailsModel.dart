// To parse this JSON data, do
//
//     final placeDetailModel = placeDetailModelFromJson(jsonString);

import 'dart:convert';

PlaceDetailModel placeDetailModelFromJson(String str) => PlaceDetailModel.fromJson(json.decode(str));

String placeDetailModelToJson(PlaceDetailModel data) => json.encode(data.toJson());

class PlaceDetailModel {
  PlaceDetailModel({
    this.results,
    this.more,
  });

  List<Result> results;
  bool more;

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) => PlaceDetailModel(
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
    this.parentId,
    this.coordinates,
    this.score,
    this.countryId,
    this.type,
    this.images,
    this.attribution,
    this.name,
    this.snippetLanguageInfo,
    this.snippet,
  });

  String id;
  String parentId;
  Coordinates coordinates;
  double score;
  String countryId;
  String type;
  List<Image> images;
  List<AttributionElement> attribution;
  String name;
  dynamic snippetLanguageInfo;
  String snippet;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    parentId: json["parent_id"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    score: json["score"].toDouble(),
    countryId: json["country_id"],
    type: json["type"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    attribution: List<AttributionElement>.from(json["attribution"].map((x) => AttributionElement.fromJson(x))),
    name: json["name"],
    snippetLanguageInfo: json["snippet_language_info"],
    snippet: json["snippet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "coordinates": coordinates.toJson(),
    "score": score,
    "country_id": countryId,
    "type": type,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "attribution": List<dynamic>.from(attribution.map((x) => x.toJson())),
    "name": name,
    "snippet_language_info": snippetLanguageInfo,
    "snippet": snippet,
  };
}

class AttributionElement {
  AttributionElement({
    this.sourceId,
    this.url,
  });

  String sourceId;
  String url;

  factory AttributionElement.fromJson(Map<String, dynamic> json) => AttributionElement(
    sourceId: json["source_id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceId,
    "url": url,
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

  SourceId sourceId;
  String sourceUrl;
  String owner;
  String ownerUrl;
  License license;
  String caption;
  ImageAttribution attribution;
  Sizes sizes;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    sourceId: sourceIdValues.map[json["source_id"]],
    sourceUrl: json["source_url"],
    owner: json["owner"],
    ownerUrl: json["owner_url"],
    license: licenseValues.map[json["license"]],
    caption: json["caption"],
    attribution: ImageAttribution.fromJson(json["attribution"]),
    sizes: Sizes.fromJson(json["sizes"]),
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceIdValues.reverse[sourceId],
    "source_url": sourceUrl,
    "owner": owner,
    "owner_url": ownerUrl,
    "license": licenseValues.reverse[license],
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

  AttributionFormat format;
  String attributionText;
  String attributionLink;
  License licenseText;
  String licenseLink;

  factory ImageAttribution.fromJson(Map<String, dynamic> json) => ImageAttribution(
    format: attributionFormatValues.map[json["format"]],
    attributionText: json["attribution_text"],
    attributionLink: json["attribution_link"],
    licenseText: licenseValues.map[json["license_text"]],
    licenseLink: json["license_link"],
  );

  Map<String, dynamic> toJson() => {
    "format": attributionFormatValues.reverse[format],
    "attribution_text": attributionText,
    "attribution_link": attributionLink,
    "license_text": licenseValues.reverse[licenseText],
    "license_link": licenseLink,
  };
}

enum AttributionFormat { ATTRIBUTION_LICENSE }

final attributionFormatValues = EnumValues({
  "{attribution} / {license}": AttributionFormat.ATTRIBUTION_LICENSE
});

enum License { CC_BY_SA_20, CC_BY_SA_30, LICENSE_CC_BY_SA_30 }

final licenseValues = EnumValues({
  "CC BY-SA 2.0": License.CC_BY_SA_20,
  "CC BY-SA 3.0": License.CC_BY_SA_30,
  "CC-BY-SA-3.0": License.LICENSE_CC_BY_SA_30
});

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
  MediumFormat format;

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    bytes: json["bytes"],
    format: mediumFormatValues.map[json["format"]],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "bytes": bytes,
    "format": mediumFormatValues.reverse[format],
  };
}

enum MediumFormat { JPG }

final mediumFormatValues = EnumValues({
  "jpg": MediumFormat.JPG
});

enum SourceId { WIKIVOYAGE, WIKIPEDIA }

final sourceIdValues = EnumValues({
  "wikipedia": SourceId.WIKIPEDIA,
  "wikivoyage": SourceId.WIKIVOYAGE
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
