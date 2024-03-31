import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_api/config/config.dart';
import 'package:movies_flutter_api/data/models/movie_model.dart';
import 'package:movies_flutter_api/modules/home/views/search_view.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  final _btmMenuIndex = 0.obs;
  final Map<String, String> headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
  };

  int get btmMenuIndex => _btmMenuIndex.value;
  set btmMenuIndex(int index) => _btmMenuIndex.value = index;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<List<Movie>> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> results = jsonData['results'];
        List<Movie> movies = [];
        for (var movieData in results) {
          String id = movieData['id'] ?? '';
          String title = movieData['titleText']['text'];
          String posterUrl = movieData['primaryImage'] != null &&
                  movieData['primaryImage']['url'] != null
              ? '${movieData['primaryImage']['url']}'
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
        }
        return movies;
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
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['results']; // Pristupamo 'results' objektu
        if (results != null && results['averageRating'] != null) {
          double? rating = double.tryParse(results['averageRating'].toString());
          return rating;
        } else {}
      } else {
        throw 'Greška prilikom slanja zahteva: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Greška prilikom slanja zahteva: $error';
    }
    return null;
  }

  void searchMovie(String query) {
    String baseUrl =
        'https://moviesdatabase.p.rapidapi.com/titles/search/title/';
     String pretragaUrl = '$baseUrl$query?exact=false';

    Get.to(SearchView(url: pretragaUrl));
  }
}
