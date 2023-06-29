import 'dart:math';

import 'package:carousel/app/controllers/home_controller.dart';
import 'package:carousel/app/models/food_carousel.dart';
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
        appBar: AppBar(title: const Text('Carousel'), centerTitle: true),
        body: Column(
          children: [
            // carousel
            Container(
                // width: double.infinity,
                height: MediaQuery.sizeOf(context).height * .35,
                padding: EdgeInsets.only(bottom: 20, top: 10),
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
                            margin: EdgeInsets.symmetric(horizontal: 5),
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
                          ],
                      ),
                    );
                  },
                )),
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
    
     if(index == _indexPage.floor() ){
       var scale = 1- (_indexPage-index)*(1-_scaleFactor);
       var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
       matrix = Matrix4.diagonal3Values(1, scale, 1)..setTranslationRaw(0, trans, 0);
    
     }else if(index == _indexPage.floor() + 1 ){
       var scale = _scaleFactor+(_indexPage-index+1)*(1-_scaleFactor);
       var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
       matrix = Matrix4.diagonal3Values(1, scale, 1)..setTranslationRaw(0, trans, 0);
     
     }else if(index == _indexPage.floor() - 1 ){
       var scale = 1- (_indexPage-index)*(1-_scaleFactor);
       var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - scale) / 2;
       matrix = Matrix4.diagonal3Values(1, scale, 1)..setTranslationRaw(0, trans, 0);
     } else {
       var scale = 0.8;
       var trans = (MediaQuery.sizeOf(context).height * .23) * (1 - _scaleFactor) / 2;
       matrix = Matrix4.diagonal3Values(1, scale, 1)..setTranslationRaw(0, trans, 1);
    
     }
    return matrix;
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

