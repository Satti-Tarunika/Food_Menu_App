import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/cart_manager.dart';
import '../models/favorite_manager.dart';

class FoodDetailsScreen extends StatefulWidget {

  final String image;
  final String name;
  final String description;
  final String price;
  final String rating;
  final String type;
  final String spicy;
  final String time;
  final String calories;

  const FoodDetailsScreen({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.type,
    required this.spicy,
    required this.time,
    required this.calories,
  });

  @override
  State<FoodDetailsScreen> createState() =>
      _FoodDetailsScreenState();
}

class _FoodDetailsScreenState
    extends State<FoodDetailsScreen> {

  int quantity = 1;

  late bool isFavorite;

  @override
  void initState() {
    super.initState();

    isFavorite =
        FavoriteManager.isFavorite(
      widget.name,
    );
  }

  String getDetailedDescription() {

    switch (widget.name) {

      case "Cheese Burger":
        return "Our Cheese Burger is made with a juicy grilled beef patty, fresh lettuce, ripe tomatoes and a generous layer of melted cheese. It is finished with our creamy signature sauce and served inside a soft toasted burger bun. Perfect for anyone looking for a filling and delicious classic burger.";

      case "Italian Pizza":
        return "A classic Italian-inspired pizza prepared with a thin and crispy base, rich tomato sauce and plenty of melted mozzarella cheese. It is topped with fresh vegetables and aromatic herbs, then baked until the crust becomes golden and the cheese turns perfectly bubbly.";

      case "Creamy Pasta":
        return "Delicious pasta cooked until perfectly tender and tossed in a rich, creamy white sauce. The dish is combined with fresh vegetables, herbs and parmesan cheese to create a smooth and comforting meal.";

      case "Chicken Biryani":
        return "Fragrant basmati rice is layered with tender marinated chicken, fried onions, mint, coriander and traditional biryani spices. The rice is cooked slowly so that every grain absorbs the rich flavour of the chicken and aromatic masala.";

      case "Guntur Chicken":
        return "A fiery Andhra speciality inspired by the famous flavours of Guntur. Tender chicken pieces are cooked with fresh green chillies, red chilli powder, curry leaves, garlic and aromatic spices. This dish has a bold, spicy and slightly smoky flavour.";

      case "Gongura Mutton":
        return "A traditional Andhra favourite made with tender mutton and tangy Gongura leaves. The meat is slow-cooked with onions, garlic and a carefully balanced blend of Andhra spices. The natural sourness of Gongura gives this dish its distinctive flavour.";

      case "Andhra Chicken Biryani":
        return "A spicy regional variation of chicken biryani prepared with aromatic rice, juicy chicken, green chillies, fried onions, mint and traditional Andhra masalas. It offers a stronger chilli kick while maintaining the rich aroma of perfectly cooked rice.";

      case "Pesarattu":
        return "Pesarattu is a traditional Andhra green gram dosa prepared by grinding soaked moong dal with ginger and green chillies. The batter is spread thin on a hot pan until crisp and golden. It is commonly served with ginger chutney and upma.";

      case "Punugulu":
        return "Crispy golden Punugulu are a popular Andhra evening snack made using fermented rice and urad dal batter. Small portions are deep-fried until crunchy outside and soft inside. They are traditionally enjoyed with spicy peanut or coconut chutney.";

      case "Chicken 65":
        return "Chicken 65 features bite-sized pieces of chicken marinated with chilli, ginger, garlic, yogurt and aromatic spices. The chicken is fried until crisp outside while remaining juicy inside, then finished with curry leaves and green chillies.";

      case "Chocolate Cake":
        return "A rich and moist chocolate cake prepared with layers of soft chocolate sponge and smooth chocolate cream. The cake is finished with a glossy chocolate topping that gives every bite a deep cocoa flavour.";

      case "Bobbatlu":
        return "Bobbatlu is a traditional Telugu sweet made with soft wheat or maida dough and a delicious filling of cooked chana dal, jaggery and cardamom. It is rolled thin and cooked until golden and soft.";

      default:
        return widget.description;
    }
  }

  void addToCart() {

    final priceValue =
        double.parse(
      widget.price.replaceAll('₹', ''),
    );

    for (
      int i = 0;
      i < quantity;
      i++
    ) {

      CartManager.addItem(
        CartItem(
          image: widget.image,
          name: widget.name,
          price: widget.price,
          priceValue: priceValue,
        ),
      );
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "${widget.name} added to cart 🛒",
        ),

        backgroundColor:
            Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final isVeg =
        widget.type == "Veg";

    return Scaffold(

      backgroundColor:
          const Color(0xff0D1117),

      body: CustomScrollView(

        slivers: [

          SliverAppBar(

            expandedHeight: 280,

            pinned: true,

            backgroundColor:
                const Color(0xff0D1117),

            leading: IconButton(

              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back,
              ),
            ),

            actions: [

              IconButton(

                onPressed: () {

                  final priceValue =
                      double.parse(
                    widget.price
                        .replaceAll(
                      '₹',
                      '',
                    ),
                  );

                  FavoriteManager
                      .toggleFavorite(

                    CartItem(
                      image:
                          widget.image,

                      name:
                          widget.name,

                      price:
                          widget.price,

                      priceValue:
                          priceValue,
                    ),
                  );

                  setState(() {

                    isFavorite =
                        FavoriteManager
                            .isFavorite(
                      widget.name,
                    );
                  });
                },

                icon: Icon(

                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,

                  color: isFavorite
                      ? Colors.red
                      : Colors.white,
                ),
              ),
            ],

            flexibleSpace:
                FlexibleSpaceBar(

              background:
                  Image.network(

                widget.image,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {

                  return Container(

                    color:
                        const Color(
                      0xff222831,
                    ),

                    child:
                        const Icon(
                      Icons.fastfood,
                      size: 70,
                      color:
                          Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(

            child: Padding(

              padding:
                  const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(

                          widget.name,

                          style:
                              const TextStyle(
                            fontSize: 27,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),

                        decoration:
                            BoxDecoration(

                          color: isVeg
                              ? Colors.green
                                  .withOpacity(
                                  0.15,
                                )
                              : Colors.red
                                  .withOpacity(
                                  0.15,
                                ),

                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),

                        child: Text(

                          widget.type,

                          style: TextStyle(

                            color: isVeg
                                ? Colors.green
                                : Colors.red,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color:
                            Colors.amber,
                        size: 20,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        widget.rating,

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Text(
                        "• Highly Rated",

                        style:
                            TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(

                    widget.price,

                    style:
                        const TextStyle(
                      color:
                          Colors.orange,
                      fontSize: 27,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Food Information",

                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      Expanded(
                        child: infoBox(
                          Icons.timer_outlined,
                          "Preparation",
                          widget.time,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: infoBox(
                          Icons.local_fire_department,
                          "Calories",
                          widget.calories,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Expanded(
                        child: infoBox(
                          Icons.whatshot,
                          "Spicy Level",
                          widget.spicy,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: infoBox(
                          isVeg
                              ? Icons.eco
                              : Icons.restaurant,
                          "Food Type",
                          widget.type,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "Description",

                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    getDetailedDescription(),

                    style:
                        const TextStyle(
                      color:
                          Colors.grey,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Container(

                    padding:
                        const EdgeInsets.all(
                      15,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(
                        0xff171C22,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),
                    ),

                    child: Row(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,

                      children: [

                        foodFeature(
                          Icons.restaurant,
                          "Fresh",
                        ),

                        foodFeature(
                          Icons.local_dining,
                          "Chef Special",
                        ),

                        foodFeature(
                          Icons.thumb_up,
                          "Popular",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(

                    "Quantity",

                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      quantityButton(
                        Icons.remove,

                        () {

                          if (quantity > 1) {

                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),

                      SizedBox(

                        width: 55,

                        child: Center(

                          child: Text(

                            quantity.toString(),

                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      quantityButton(
                        Icons.add,

                        () {

                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(

                    width: double.infinity,

                    height: 58,

                    child:
                        ElevatedButton(

                      onPressed:
                          addToCart,

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            Colors.orange,

                        foregroundColor:
                            Colors.white,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),

                      child: Text(

                        "Add $quantity to Cart • ₹${(double.parse(widget.price.replaceAll('₹', '')) * quantity).toStringAsFixed(0)}",

                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(
    IconData icon,
    String title,
    String value,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(12),

      decoration:
          BoxDecoration(

        color:
            const Color(0xff171C22),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Row(

        children: [

          Icon(
            icon,
            color: Colors.orange,
            size: 22,
          ),

          const SizedBox(width: 8),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                      const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityButton(
    IconData icon,
    VoidCallback onTap,
  ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding:
            const EdgeInsets.all(10),

        decoration:
            BoxDecoration(

          color:
              const Color(0xff211A10),

          borderRadius:
              BorderRadius.circular(10),
        ),

        child: Icon(
          icon,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget foodFeature(
    IconData icon,
    String title,
  ) {

    return Column(

      children: [

        Icon(
          icon,
          color: Colors.orange,
          size: 25,
        ),

        const SizedBox(height: 5),

        Text(
          title,

          style:
              const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}