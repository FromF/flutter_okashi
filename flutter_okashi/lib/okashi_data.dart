import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<OkashiItem>> fetchOkashi(String keyword) async {
  final keywordEncode = Uri.encodeComponent(keyword);
  final response = await http.get('https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=$keywordEncode&max=10&order=r');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseOKashi, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load okashi');
  }
}

// A function that converts a response body into a List<OkashiItem>.
List<OkashiItem> parseOKashi(String responseBody) {
  final parsed = jsonDecode(responseBody)['item'].cast<Map<String, dynamic>>();

  return parsed.map<OkashiItem>((json) => OkashiItem.fromJson(json)).toList();
}

class OkashiItem {
  final String name;
  final String image;
  final String link;

  OkashiItem({this.name, this.image, this.link});

  factory OkashiItem.fromJson(Map<String, dynamic> json) {
    return OkashiItem(
      name:json['name'],
      image:json['image'],
      link:json['url']
    );
  }
}
