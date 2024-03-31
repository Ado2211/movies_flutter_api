import 'package:get/get.dart';
import 'package:movies_flutter_api/modules/movie/controllers/movie_controller.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}