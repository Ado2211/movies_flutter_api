

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';
import 'package:movies_flutter_api/modules/home/views/widgets/top_search.dart';
import 'package:movies_flutter_api/modules/home/views/widgets/upcoming_movies.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
   
    return
    Scaffold(
      backgroundColor: Color(0xFF162B3C),
      body: Column(
        children: [
          TopSearch(),
          MovieWidget(),
        ],
      ),
    );
  }
}
