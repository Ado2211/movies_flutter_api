import 'package:get/get.dart';
import 'package:movies_flutter_api/modules/home/views/home_view.dart';
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
   
  ];
}
