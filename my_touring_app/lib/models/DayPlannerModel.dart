// To parse this JSON data, do
//
//     final dayPlannerModel = dayPlannerModelFromJson(jsonString);

import 'dart:convert';

DayPlannerModel dayPlannerModelFromJson(String str) => DayPlannerModel.fromJson(json.decode(str));

String dayPlannerModelToJson(DayPlannerModel data) => json.encode(data.toJson());

class DayPlannerModel {
  DayPlannerModel({
    this.results,
    this.more,
  });

  List<Result> results;
  bool more;

  factory DayPlannerModel.fromJson(Map<String, dynamic> json) => DayPlannerModel(
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
    this.location,
    this.hotel,
    this.days,
    this.seed,
  });

  Location location;
  dynamic hotel;
  List<Day> days;
  int seed;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    location: Location.fromJson(json["location"]),
    hotel: json["hotel"],
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
    seed: json["seed"],
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "hotel": hotel,
    "days": List<dynamic>.from(days.map((x) => x.toJson())),
    "seed": seed,
  };
}

class Day {
  Day({
    this.date,
    this.itineraryItems,
  });

  DateTime date;
  List<ItineraryItem> itineraryItems;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    date: DateTime.parse(json["date"]),
    itineraryItems: List<ItineraryItem>.from(json["itinerary_items"].map((x) => ItineraryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "itinerary_items": List<dynamic>.from(itineraryItems.map((x) => x.toJson())),
  };
}

class ItineraryItem {
  ItineraryItem({
    this.title,
    this.description,
    this.poi,
  });

  String title;
  String description;
  Poi poi;

  factory ItineraryItem.fromJson(Map<String, dynamic> json) => ItineraryItem(
    title: json["title"],
    description: json["description"],
    poi: Poi.fromJson(json["poi"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "poi": poi.toJson(),
  };
}

class Poi {
  Poi({
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
  });

  String id;
  String name;
  Coordinates coordinates;
  double score;
  List<Image> images;
  BookingInfo bookingInfo;
  List<AttributionElement> attribution;
  int priceTier;
  dynamic snippetLanguageInfo;
  String snippet;
  Id locationId;

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
    id: json["id"],
    name: json["name"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    score: json["score"].toDouble(),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    bookingInfo: json["booking_info"] == null ? null : BookingInfo.fromJson(json["booking_info"]),
    attribution: List<AttributionElement>.from(json["attribution"].map((x) => AttributionElement.fromJson(x))),
    priceTier: json["price_tier"] == null ? null : json["price_tier"],
    snippetLanguageInfo: json["snippet_language_info"],
    snippet: json["snippet"],
    locationId: idValues.map[json["location_id"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coordinates": coordinates.toJson(),
    "score": score,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "booking_info": bookingInfo == null ? null : bookingInfo.toJson(),
    "attribution": List<dynamic>.from(attribution.map((x) => x.toJson())),
    "price_tier": priceTier == null ? null : priceTier,
    "snippet_language_info": snippetLanguageInfo,
    "snippet": snippet,
    "location_id": idValues.reverse[locationId],
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

enum SourceId { OPENSTREETMAP, WIKIPEDIA, WIKIVOYAGE, FACEBOOK, FLICKR }

final sourceIdValues = EnumValues({
  "facebook": SourceId.FACEBOOK,
  "flickr": SourceId.FLICKR,
  "openstreetmap": SourceId.OPENSTREETMAP,
  "wikipedia": SourceId.WIKIPEDIA,
  "wikivoyage": SourceId.WIKIVOYAGE
});

class BookingInfo {
  BookingInfo({
    this.vendor,
    this.vendorObjectId,
    this.vendorObjectUrl,
    this.price,
  });

  String vendor;
  String vendorObjectId;
  String vendorObjectUrl;
  Price price;

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
    vendor: json["vendor"],
    vendorObjectId: json["vendor_object_id"],
    vendorObjectUrl: json["vendor_object_url"],
    price: Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "vendor": vendor,
    "vendor_object_id": vendorObjectId,
    "vendor_object_url": vendorObjectUrl,
    "price": price.toJson(),
  };
}

class Price {
  Price({
    this.currency,
    this.amount,
  });

  String currency;
  String amount;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    currency: json["currency"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "amount": amount,
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
  String license;
  String caption;
  ImageAttribution attribution;
  Sizes sizes;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    sourceId: sourceIdValues.map[json["source_id"]],
    sourceUrl: json["source_url"],
    owner: json["owner"],
    ownerUrl: json["owner_url"],
    license: json["license"] == null ? null : json["license"],
    caption: json["caption"] == null ? null : json["caption"],
    attribution: ImageAttribution.fromJson(json["attribution"]),
    sizes: Sizes.fromJson(json["sizes"]),
  );

  Map<String, dynamic> toJson() => {
    "source_id": sourceIdValues.reverse[sourceId],
    "source_url": sourceUrl,
    "owner": owner,
    "owner_url": ownerUrl,
    "license": license == null ? null : license,
    "caption": caption == null ? null : caption,
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
  String licenseText;
  String licenseLink;

  factory ImageAttribution.fromJson(Map<String, dynamic> json) => ImageAttribution(
    format: attributionFormatValues.map[json["format"]],
    attributionText: json["attribution_text"],
    attributionLink: json["attribution_link"],
    licenseText: json["license_text"] == null ? null : json["license_text"],
    licenseLink: json["license_link"] == null ? null : json["license_link"],
  );

  Map<String, dynamic> toJson() => {
    "format": attributionFormatValues.reverse[format],
    "attribution_text": attributionText,
    "attribution_link": attributionLink,
    "license_text": licenseText == null ? null : licenseText,
    "license_link": licenseLink == null ? null : licenseLink,
  };
}

enum AttributionFormat { ATTRIBUTION_LICENSE, ATTRIBUTION }

final attributionFormatValues = EnumValues({
  "{attribution}": AttributionFormat.ATTRIBUTION,
  "{attribution} / {license}": AttributionFormat.ATTRIBUTION_LICENSE
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

enum Id { LONDON }

final idValues = EnumValues({
  "London": Id.LONDON
});

class Location {
  Location({
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

  Id id;
  String parentId;
  Coordinates coordinates;
  double score;
  String countryId;
  String type;
  List<Image> images;
  List<AttributionElement> attribution;
  Id name;
  dynamic snippetLanguageInfo;
  String snippet;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: idValues.map[json["id"]],
    parentId: json["parent_id"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    score: json["score"].toDouble(),
    countryId: json["country_id"],
    type: json["type"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    attribution: List<AttributionElement>.from(json["attribution"].map((x) => AttributionElement.fromJson(x))),
    name: idValues.map[json["name"]],
    snippetLanguageInfo: json["snippet_language_info"],
    snippet: json["snippet"],
  );

  Map<String, dynamic> toJson() => {
    "id": idValues.reverse[id],
    "parent_id": parentId,
    "coordinates": coordinates.toJson(),
    "score": score,
    "country_id": countryId,
    "type": type,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "attribution": List<dynamic>.from(attribution.map((x) => x.toJson())),
    "name": idValues.reverse[name],
    "snippet_language_info": snippetLanguageInfo,
    "snippet": snippet,
  };
}

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
