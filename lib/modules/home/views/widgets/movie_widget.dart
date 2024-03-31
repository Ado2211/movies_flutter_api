import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/config/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_flutter_api/data/models/movie_model.dart';
import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';
import 'package:movies_flutter_api/routes/app_routes.dart';

class MovieWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final String url;

  const MovieWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return FutureBuilder<List<Movie>>(
      future: homeController.fetchData(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text(''));
        } else {
          List<Movie>? movies = snapshot.data;
          if (movies == null || movies.isEmpty) {
            return const Center(child: Text('Nema dostupnih filmova'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Image.asset(
                        iconPath,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '(134)',
                        style: TextStyle(color: AppColors.greyText),
                      ),
                      const SizedBox(width: 7),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Prikaži sve',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 265,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                          padding: EdgeInsets.only(
                            left: index == 0 ? 18.0 : 0,
                            right: 18.0,
                          ),
                          child: SizedBox(
                            width: Get.width / 2.7,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.width / 2.7 * 1.3,
                                  width: Get.width / 2.7,
                                  child: FutureBuilder(
                                    future: movie.posterUrl.isNotEmpty
                                        ? precacheImage(
                                            NetworkImage(movie.posterUrl),
                                            context)
                                        : null,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return movie.posterUrl.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                child: Image.network(
                                                  movie.posterUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                const SizedBox(height: 7),
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
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
                                    const Spacer(),
                                    Image.asset(
                                      'assets/images/prime.png',
                                    ),
                                    const SizedBox(width: 3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
