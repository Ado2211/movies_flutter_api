import 'package:get/get.dart';
import 'package:movies_flutter_api/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBindings(),
    ),
   
  ];
}
