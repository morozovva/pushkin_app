import 'package:flutter/material.dart';

class InternetError extends StatelessWidget {
  const InternetError({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var iconColor = isDarkMode ? Colors.white : Colors.black;
    return Stack(children: [
      ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.signal_wifi_connected_no_internet_4,
            size: 70,
            color: iconColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
              "К сожалению, не удалось подключиться к интернету.\n\n Проверьте ваше подключение и попробуйте еще раз. Если проблема не устранится, значит мы уже работаем над ней.")
        ]),
      ),
    ]);
  }
}
