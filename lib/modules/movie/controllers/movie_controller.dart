import 'dart:convert';

import 'package:get/get.dart';
import 'package:movies_flutter_api/config/config.dart';
import 'package:movies_flutter_api/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  final Map<String, String> headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
  };
  Rx<Movie?> movie = Rx<Movie?>(null);

  Future<Movie> fetchDataWithId(String movieId) async {
    final String url = 'https://moviesdatabase.p.rapidapi.com/titles/$movieId';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData.containsKey('results')) {
          final results = jsonData['results'];
          String id = results['id'];
          String title = results['titleText']?['text'] ?? '';
          String posterUrl = results['primaryImage'] != null &&
                  results['primaryImage']['url'] != null
              ? '${results['primaryImage']['url']}'
              : '';
          double? rating = await fetchRating(id);

          return Movie(
              id: id, title: title, posterUrl: posterUrl, rating: rating);
        } else {
          throw 'Podaci o filmu nisu pronađeni';
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
}
