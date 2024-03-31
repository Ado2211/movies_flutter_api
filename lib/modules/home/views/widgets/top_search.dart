import 'package:flutter/material.dart';
import 'package:movies_flutter_api/config/app_colors.dart';
import 'package:movies_flutter_api/modules/home/controllers/home_controller.dart';

class TopSearch extends StatelessWidget {
  const TopSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/search_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45, bottom: 10),
                  child: Image.asset(
                    'assets/images/top_icon.png', // Dodajte putanju do ikone
                  ),
                ),
                const Text(
                  'Zdravo, \nšta ćeš gledati?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/search_icon.png', // Dodajte putanju do ikone
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Traži film, seriju, glumca',
                            hintStyle: TextStyle(color: AppColors.greyText),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: AppColors.greyText),
                          onSubmitted: (value) {
                            HomeController homeController = HomeController();
                            homeController.searchMovie(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
