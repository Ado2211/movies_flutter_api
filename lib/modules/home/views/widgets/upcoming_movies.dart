import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/config/app_colors.dart';
import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/newest.png', // Dodajte putanju do ikone
              ),
              SizedBox(width: 10),
              Text(
                'Najnoviji',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigacija na drugi ekran ili izvođenje odgovarajuće akcije
                },
                child: Text(
                  'Prikaži sve',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 265,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.movies.length,
              itemBuilder: (context, index) {
                final movie = homeController.movies[index];
                return Padding(
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
                          child: movie.posterUrl.isNotEmpty
                              ? Image.network(
                                  movie.posterUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/movie.jpg',
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          movie.title,
                          maxLines: 2, // Ograničavanje na dva reda
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Row(
                         mainAxisSize: MainAxisSize.max, // Poravnanje prema dnu
                          children: [
                            RatingBar.builder(
                              initialRating: movie.rating ?? 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 16,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: AppColors.lightBlue,
                              ),
                              onRatingUpdate: (rating) {
                               
                              },
                            ),
                            Spacer(), 
                            Image.asset(
                              'assets/images/prime.png', // Dodajte putanju do ikone
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
