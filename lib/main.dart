import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  int pageCount = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) {
        return;
      }
      if (pageController.page >= pageCount - 1) {
        pageController.animateToPage(0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn);
      } else {
        pageController.nextPage(
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: SizedBox(
          width: 100,
          child: Image.asset(
            "assets/logo.png",
            color: Colors.blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Location",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 18,
                    )
                  ],
                ),
                Text(
                  "CURRENT LOCATION",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            LimitedBox(
              maxHeight: 250,
              child: Stack(
                children: [
                  PageView(
                    controller: pageController,
                    children: [
                      AdsSlideCard(
                        slideImage: "assets/f1.jpg",
                      ),
                      AdsSlideCard(
                        slideImage: "assets/f3.jpg",
                      ),
                      AdsSlideCard(
                        slideImage: "assets/f4.jpg",
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 18.0,
                    left: 0.0,
                    right: 0.0,
                    child: Center(
                      child: SlideIndicator(
                        pageController: pageController,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MenuFeature(iconAsset: "assets/m_tuktuk.png", name: "Taxi"),
                  MenuFeature(
                    iconAsset: "assets/m_express.png",
                    name: "Express",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_food.png",
                    name: "Food",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_grocery.png",
                    name: "Grocery",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_flower.png",
                    name: "Flower",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_shop.png",
                    name: "Shop",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_bakery.png",
                    name: "Bakery",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_alcohol.png",
                    name: "Alcohol",
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Trending Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxHeight: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [TrendingCard(), TrendingCard(), TrendingCard()],
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 8,
            ),
            PromoteShopCard(
              image: "assets/f8.jpg",
            ),
            PromoteShopCard(
              image: "assets/f9.jpg",
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Track")),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), title: Text("Inbox")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Account")),
        ],
      ),
    );
  }
}

class SlideIndicator extends AnimatedWidget {
  final PageController pageController;

  SlideIndicator({this.pageController}) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, buildIndicator),
    );
  }

  Widget buildIndicator(int index) {
    print("build $index");
    double select = max(
      0.0,
      1.0 - ((pageController.page ?? pageController.initialPage) - index).abs(),
    );
    double decrease = 10 * select;
    return Container(
      width: 30,
      child: Center(
        child: Container(
          width: 20 - decrease,
          height: 4,
          decoration: BoxDecoration(
              color: decrease == 10.0 ? Colors.blue : Colors.black,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class PromoteShopCard extends StatelessWidget {
  final String image;

  PromoteShopCard({this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class TrendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 200,
        width: 250,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/f7.jpg",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

class MenuFeature extends StatelessWidget {
  final String iconAsset;
  final String name;

  MenuFeature({this.iconAsset, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 50, height: 50, child: Image.asset(iconAsset)),
            Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class AdsSlideCard extends StatelessWidget {
  final String slideImage;

  AdsSlideCard({this.slideImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                slideImage,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
