import 'dart:math';

import 'package:carousel/app/controllers/home_controller.dart';
import 'package:carousel/app/models/food_carousel.dart';
import 'package:carousel/app/widgets/custom_card_info.dart';
import 'package:carousel/app/widgets/custom_rating_bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  HomeController controller = HomeController();
  double _indexPage = 0;
  double _scaleFactor = 0.8;

  List<FoodCarousel> list = [];
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _indexPage = _pageController.page!;
      });
    });
    setState(() {
      list = controller.load();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brasil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Camboriú',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_rounded, color: Colors.grey)
                ],
              ),
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.deepPurple,
              ),
              child: Icon(Icons.search, color: Colors.white),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .35,
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: PageView.builder(
                controller: _pageController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Matrix4 matrix = getTransform(index, context);

                  var food = list[index];
                  return Transform(
                    transform: matrix,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: MediaQuery.sizeOf(context).height * .23,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(food.imageUrl),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        CustomCardInfo(food: food)
                      ],
                    ),
                  );
                },
              ),
            ),
            DotsIndicator(
              dotsCount: list.length,
              position: _indexPage.roundToDouble().toInt(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            // content
            Expanded(child: Container())
          ],
        ));
  }

  Matrix4 getTransform(int index, BuildContext context) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _indexPage.floor()) {
      var scale = 1 - (_indexPage - index) * (1 - _scaleFactor);
      var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else if (index == _indexPage.floor() + 1) {
      var scale = _scaleFactor + (_indexPage - index + 1) * (1 - _scaleFactor);
      var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else if (index == _indexPage.floor() - 1) {
      var scale = 1 - (_indexPage - index) * (1 - _scaleFactor);
      var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else {
      var scale = 0.8;
      var trans =
          (MediaQuery.sizeOf(context).height * .23) * (1 - _scaleFactor) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, trans, 1);
    }
    return matrix;
  }
}
