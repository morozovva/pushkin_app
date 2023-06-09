import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushkin_app/widget/internet_error.dart';

import '../screen/exhibition_screen.dart';
import '../provider/exhibition_provider.dart';

class ExhibitionGrid extends StatelessWidget {
  const ExhibitionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final exhibitions =
        Provider.of<ExhibitionProvider>(context, listen: false).exhibitions;
    return exhibitions.isEmpty
        ? const Center(
            child: InternetError(),
          )
        : ListView.builder(
            itemCount: exhibitions.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  ExhibitionScreen.routeName,
                  arguments: exhibitions[index].id),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.only(bottom: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      child: Image.network(
                        exhibitions[index].imageUrl,
                        height: 244,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const SizedBox(
                              height: 244,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      height: 72,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exhibitions[index].title,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
