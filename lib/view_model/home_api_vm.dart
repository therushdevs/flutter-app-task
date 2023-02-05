// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HomeApiVM welcomeFromJson(String str) => HomeApiVM.fromJson(json.decode(str));

String welcomeToJson(HomeApiVM data) => json.encode(data.toJson());

class HomeApiVM {
  HomeApiVM({
    required this.count,
    required this.entries,
  });

  int count;
  List<Entry> entries;

  factory HomeApiVM.fromJson(Map<String, dynamic> json) => HomeApiVM(
    count: json["count"],
    entries: List<Entry>.from(json["entries"].map((x) => Entry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "entries": List<dynamic>.from(entries.map((x) => x.toJson())),
  };
}

class Entry {
  Entry({
    required this.api,
    required this.description,
    required this.auth,
    required this.https,
    required this.cors,
    required this.link,
    required this.category,
  });

  String api;
  String description;
  Auth auth;
  bool https;
  Cors cors;
  String link;
  String category;

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    api: json["API"],
    description: json["Description"],
    auth: authValues.map[json["Auth"]]!,
    https: json["HTTPS"],
    cors: corsValues.map[json["Cors"]]!,
    link: json["Link"],
    category: json["Category"],
  );

  Map<String, dynamic> toJson() => {
    "API": api,
    "Description": description,
    "Auth": authValues.reverse[auth],
    "HTTPS": https,
    "Cors": corsValues.reverse[cors],
    "Link": link,
    "Category": category,
  };
}

enum Auth { API_KEY, EMPTY, O_AUTH, X_MASHAPE_KEY, USER_AGENT }

final authValues = EnumValues({
  "apiKey": Auth.API_KEY,
  "": Auth.EMPTY,
  "OAuth": Auth.O_AUTH,
  "User-Agent": Auth.USER_AGENT,
  "X-Mashape-Key": Auth.X_MASHAPE_KEY
});

enum Cors { YES, NO, UNKNOWN, UNKOWN }

final corsValues = EnumValues({
  "no": Cors.NO,
  "unknown": Cors.UNKNOWN,
  "unkown": Cors.UNKOWN,
  "yes": Cors.YES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
