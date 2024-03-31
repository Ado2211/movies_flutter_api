import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/config/app_colors.dart';

import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';
import 'package:movies_flutter_api/modules/home/views/widgets/top_search.dart';
import 'package:movies_flutter_api/modules/home/views/widgets/movie_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopSearch(),
            SizedBox(height: 10),
            MovieWidget(
              title: 'Najnoviji',
              iconPath: 'assets/images/newest.png',
              url:
                  'https://moviesdatabase.p.rapidapi.com/titles/x/upcoming?page=4',
            ),
            MovieWidget(
              title: 'Filmovi',
              iconPath: 'assets/images/movies_icon.png',
              url: 'https://moviesdatabase.p.rapidapi.com/titles?page=13',
            ),
            MovieWidget(
              title: 'Serije',
              iconPath: 'assets/images/series_icon.png',
              url: 'https://moviesdatabase.p.rapidapi.com/titles?page=14',
            ),
          ],
        ),
      ),
    );
  }
}
