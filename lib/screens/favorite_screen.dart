import 'package:flutter/material.dart';

import '../models/favorite_manager.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() =>
      _FavoriteScreenState();
}

class _FavoriteScreenState
    extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {

    final favorites =
        FavoriteManager.favorites;

    return Scaffold(
      backgroundColor:
          const Color(0xff0D1117),

      appBar: AppBar(
        backgroundColor:
            const Color(0xff0D1117),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Favorites ❤️",

          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: favorites.isEmpty

          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.favorite_border,
                    size: 85,
                    color:
                        Colors.grey.shade700,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "No favorites yet",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Tap ❤️ on your favorite food",

                    style: TextStyle(
                      color:
                          Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )

          : ListView.builder(
              padding:
                  const EdgeInsets.all(18),

              itemCount:
                  favorites.length,

              itemBuilder:
                  (context, index) {

                final item =
                    favorites[index];

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 15,
                  ),

                  padding:
                      const EdgeInsets.all(12),

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xff171C22),

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(
                      color:
                          const Color(0xff292F36),
                    ),
                  ),

                  child: Row(
                    children: [

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),

                        child:
                            Image.network(
                          item.image,

                          height: 85,
                          width: 85,

                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              item.name,

                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              item.price,

                              style:
                                  const TextStyle(
                                color:
                                    Colors.orange,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {

                          setState(() {
                            FavoriteManager
                                .favorites
                                .removeAt(
                              index,
                            );
                          });

                        },

                        icon:
                            const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}