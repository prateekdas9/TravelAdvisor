// To parse this JSON data, do
//
//     final placeHighlightsModel = placeHighlightsModelFromJson(jsonString);

import 'dart:convert';

PlaceHighlightsModel placeHighlightsModelFromJson(String str) => PlaceHighlightsModel.fromJson(json.decode(str));

String placeHighlightsModelToJson(PlaceHighlightsModel data) => json.encode(data.toJson());

class PlaceHighlightsModel {
  PlaceHighlightsModel({
    this.results,
    this.more,
  });

  List<Result> results;
  bool more;

  factory PlaceHighlightsModel.fromJson(Map<String, dynamic> json) => PlaceHighlightsModel(
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
    this.pois,
    this.poiDivision,
  });

  List<Pois> pois;
  List<PoiDivision> poiDivision;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    pois: List<Pois>.from(json["pois"].map((x) => Pois.fromJson(x))),
    poiDivision: List<PoiDivision>.from(json["poi_division"].map((x) => PoiDivision.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pois": List<dynamic>.from(pois.map((x) => x.toJson())),
    "poi_division": List<dynamic>.from(poiDivision.map((x) => x.toJson())),
  };
}

class PoiDivision {
  PoiDivision({
    this.tagLabel,
    this.tagName,
    this.poiIds,
  });

  String tagLabel;
  String tagName;
  List<String> poiIds;

  factory PoiDivision.fromJson(Map<String, dynamic> json) => PoiDivision(
    tagLabel: json["tag_label"],
    tagName: json["tag_name"],
    poiIds: List<String>.from(json["poi_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tag_label": tagLabel,
    "tag_name": tagName,
    "poi_ids": List<dynamic>.from(poiIds.map((x) => x)),
  };
}

class Pois {
  Pois({
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
    this.distance,
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
  int distance;

  factory Pois.fromJson(Map<String, dynamic> json) => Pois(
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
    distance: json["distance"],
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
    "distance": distance,
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

enum SourceId { WIKIVOYAGE, FACEBOOK, OPENSTREETMAP }

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

  SourceId sourceId;
  String sourceUrl;
  Owner owner;
  String ownerUrl;
  dynamic license;
  dynamic caption;
  ImageAttribution attribution;
  Sizes sizes;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    sourceId: sourceIdValues.map[json["source_id"]],
    sourceUrl: json["source_url"],
    owner: ownerValues.map[json["owner"]],
    ownerUrl: json["owner_url"],
    license: json["license"],
    caption: json["caption"],
    attribution: ImageAttribution.fromJson(json["attribution"]),
    sizes: Sizes.fromJson(json["sizes"]),
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceIdValues.reverse[sourceId],
    "source_url": sourceUrl,
    "owner": ownerValues.reverse[owner],
    "owner_url": ownerUrl,
    "license": license,
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
  Owner attributionText;
  String attributionLink;
  dynamic licenseText;
  dynamic licenseLink;

  factory ImageAttribution.fromJson(Map<String, dynamic> json) => ImageAttribution(
    format: attributionFormatValues.map[json["format"]],
    attributionText: ownerValues.map[json["attribution_text"]],
    attributionLink: json["attribution_link"],
    licenseText: json["license_text"],
    licenseLink: json["license_link"],
  );

  Map<String, dynamic> toJson() => {
    "format": attributionFormatValues.reverse[format],
    "attribution_text": ownerValues.reverse[attributionText],
    "attribution_link": attributionLink,
    "license_text": licenseText,
    "license_link": licenseLink,
  };
}

enum Owner { FACEBOOK }

final ownerValues = EnumValues({
  "Facebook": Owner.FACEBOOK
});

enum AttributionFormat { ATTRIBUTION }

final attributionFormatValues = EnumValues({
  "{attribution}": AttributionFormat.ATTRIBUTION
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

enum MediumFormat { JPG, PNG }

final mediumFormatValues = EnumValues({
  "jpg": MediumFormat.JPG,
  "png": MediumFormat.PNG
});

enum LocationId { RIO_DE_JANEIRO }

final locationIdValues = EnumValues({
  "Rio_de_Janeiro": LocationId.RIO_DE_JANEIRO
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
