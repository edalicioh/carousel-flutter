// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/food_carousel.dart';
import 'custom_rating_bar.dart';

class CustomCardInfo extends StatelessWidget {

  final FoodCarousel food;

  const CustomCardInfo({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
        ),
        height: MediaQuery.sizeOf(context).height * .18,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                food.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  CustomRatingBar(
                    rating: food.rating,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    food.rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${food.qtdComment.toString()} Comments",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  info(
                      label: 'Normal',
                      icon: Icons.circle_rounded,
                      color: Colors.orangeAccent),
                  info(
                      label: "${food.distance.toString()}km",
                      icon: Icons.location_on,
                      color: Colors.green),
                  info(
                      label: "${food.time.toString()}min",
                      icon: Icons.access_time_rounded,
                      color: Colors.redAccent),
                ],
              )
            ]),
      ),
    );
  }

  Widget info(
      {required String label, required IconData icon, required Color color}) {
    return Row(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
