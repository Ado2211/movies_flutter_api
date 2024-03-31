import 'package:get/get.dart';
import 'package:movies_flutter_api/modules/home/views/home_view.dart';
import 'package:movies_flutter_api/modules/movie/bindings/movie_bindings.dart';
import 'package:movies_flutter_api/modules/movie/views/movie_view.dart';
import 'package:movies_flutter_api/routes/app_routes.dart';

import '../modules/home/bindings/home_bindings.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBindings(),
    ),
   GetPage(
      name: Routes.MOVIE,
      page: () {
        final movieId = Get.parameters['movieId'];
        return MovieView(movieId: movieId ?? 'tt0000046'); 
      },
      binding: MovieBindings(),
    ),
  ];
}
