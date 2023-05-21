import 'package:flutter/material.dart';
import 'package:pushkin_app/widget/map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Карта",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 11,
            ),
            Text(
              "Найди музей на карте!",
              style: isDarkMode
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)
                  : Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
              child: Map(),
            ),
          ],
        ),
      ),
    );
  }
}
