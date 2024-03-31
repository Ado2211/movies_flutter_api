import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/config/app_colors.dart';
import 'package:movies_flutter_api/data/models/movie_model.dart';
import 'package:movies_flutter_api/modules/movie/controllers/movie_controller.dart';
import 'package:movies_flutter_api/modules/movie/views/widgets/actors.dart';
import 'package:movies_flutter_api/modules/movie/views/widgets/custom_button.dart';

class MovieView extends GetView<MovieController> {
  final String movieId;

  const MovieView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Movie>(
        future: controller.fetchDataWithId(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final movie = snapshot.data;
            if (movie == null) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * 0.7,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: movie.posterUrl.isNotEmpty
                            ? NetworkImage(movie.posterUrl)
                            : const AssetImage('assets/images/movie.jpg')
                                as ImageProvider<Object>,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            'assets/images/back_icon.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * 0.6,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: movie.rating ?? 4.5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: AppColors.lightBlue,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      movie.rating?.toStringAsFixed(1) ?? '4.5',
                                      style: const TextStyle(
                                        color: AppColors.lightBlue,
                                      ),
                                    ),
                                   const SizedBox(width: 30),
                                    const Icon(
                                      Icons.access_time,
                                      color: AppColors.lightBlue,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '1 Sat i 45min',
                                      style:
                                          TextStyle(color: AppColors.lightBlue),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const RoundedButton(
                                        imagePath: 'assets/images/Play.png',
                                        text: 'Gledaj',
                                        color: AppColors.lightBlue),
                                   const  SizedBox(width: 20),
                                   const RoundedButton(
                                        imagePath: 'assets/images/Video.png',
                                        text: 'Triler',
                                        color: AppColors.buttonBgDark),
                                   const  SizedBox(width: 20),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonBgDark,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'i',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                               const SizedBox(height: 20),
                                const Text(
                                  'U ovoj napetoj akcijskoj priči Jason Statham, Josh Hutcherson i Minnie Driver preuzimaju glavne uloge, uvlačeći nas dublje u tajanstveni svijet moćnih organizacija. G. Clay (Statham) bivši je operativac moćne i tajanstvene organizacije',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Prikaži više',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Glumci',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                   const  SizedBox(width: 8),
                                    Image.asset(
                                      'assets/images/actors.png',
                                      color: AppColors.lightBlue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const ActorsWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
