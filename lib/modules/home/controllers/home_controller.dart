import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_api/data/models/movie_model.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  final _btmMenuIndex = 0.obs;
  final movies = <Movie>[].obs;

  int get btmMenuIndex => _btmMenuIndex.value;
  set btmMenuIndex(int index) => _btmMenuIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchData() async {
    const String url = 'https://moviesdatabase.p.rapidapi.com/titles/x/upcoming?page=4';
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '7786f90c70msh921a76a3839a3e0p1a7ce7jsnc8b7cda04a74',
      'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<dynamic> results = jsonData['results'];
        for (var movieData in results) {
          String id = movieData['id'] ?? '';
          String title = movieData['titleText']['text'];
          String posterUrl = movieData['primaryImage'] != null &&
                  movieData['primaryImage']['url'] != null
              ? movieData['primaryImage']['url']
              : '';

          double? rating = await fetchRating(id);

          movies.add(
            Movie(
              id: id,
              title: title,
              posterUrl: posterUrl,
              rating: rating,
            ),
          );
          print(
              'ID: $id, Title: $title, Poster URL: $posterUrl, Rating: $rating');
        }
      } else {
        throw 'Greška prilikom slanja zahteva: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Greška prilikom slanja zahteva: $error';
    }
  }

  Future<double?> fetchRating(String movieId) async {
  final String url =
      'https://moviesdatabase.p.rapidapi.com/titles/$movieId/ratings';
  final Map<String, String> headers = {
    'X-RapidAPI-Key': '7786f90c70msh921a76a3839a3e0p1a7ce7jsnc8b7cda04a74',
    'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results']; // Pristupamo 'results' objektu
      if (results != null && results['averageRating'] != null) {
        double? rating = double.tryParse(results['averageRating'].toString());
        print('Rating for movie $movieId: $rating');
        return rating;
      } else {
        print('Rating for movie $movieId not available');
        return null;
      }
    } else {
      throw 'Greška prilikom slanja zahteva: ${response.statusCode}';
    }
  } catch (error) {
    throw 'Greška prilikom slanja zahteva: $error';
  }
}

}
