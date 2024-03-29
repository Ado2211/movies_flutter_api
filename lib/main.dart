import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_flutter_api/api/movie_api.dart';
import 'package:movies_flutter_api/modules/home/bindings/home_bindings.dart';
import 'package:movies_flutter_api/routes/app_pages.dart';
import 'package:movies_flutter_api/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
 
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(textTheme).copyWith(
            bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
          ),
        ),
        title: 'Autoskola quiz app',
        getPages: AppPages.routes,
        initialRoute: Routes.HOME,
        initialBinding: HomeBindings(),
      ),
    );
  }
}
