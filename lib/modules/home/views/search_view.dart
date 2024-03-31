import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/config/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_flutter_api/data/models/movie_model.dart';
import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';
import 'package:movies_flutter_api/routes/app_routes.dart';

class SearchView extends StatelessWidget {
  final String url;

  const SearchView({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        title: const Text(
          'Pretraga',
          style: TextStyle(color: Colors.white),
        ), // Dodajemo naslov 'Pretraga' u sredini AppBar-a
        centerTitle: true, // Centriramo naslov
      ),
      body: FutureBuilder<List<Movie>>(
        future: homeController.fetchData(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Movie>? movies = snapshot.data;
            if (movies == null || movies.isEmpty) {
              return const Center(child: Text('Nema dostupnih filmova'));
            } else {
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      final selectedMovie = movie.id;
                      Get.toNamed(Routes.MOVIE,
                          parameters: {'movieId': selectedMovie});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 100,
                            child: FutureBuilder(
                              future: movie.posterUrl.isNotEmpty
                                  ? precacheImage(
                                      NetworkImage(movie.posterUrl), context)
                                  : null,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return movie.posterUrl.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          child: Image.network(
                                            movie.posterUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            'assets/images/movie.jpg',
                                            fit: BoxFit.fitWidth,
                                          ),
                                        );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Naslov, kratki tekst i rating
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '1h-45m',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'U ovoj napetoj akcijskoj priči Jason Statham, Josh Hutcherson i Minnie Driver preuzimaju glavne uloge, uvlačeći nas dublje u tajanstveni svijet moćnih organizacija.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RatingBar.builder(
                                  initialRating: movie.rating ?? 4.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 16,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColors.lightBlue,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
