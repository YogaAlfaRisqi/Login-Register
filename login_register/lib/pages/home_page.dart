import 'package:flutter/material.dart';
import 'package:login_register/pages/login_register.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final List<String> _imagePaths = [
    "assets/images/Fullstack.png",
    "assets/images/Data.png",
    "assets/images/Front.png",
  ];
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Text(
              "Kampus Merdeka",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Popp ins',
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Course-Net Indonesia",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 250,
              width: 500,
              // Sesuaikan lebar container sesuai dengan gambar
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _imagePaths[index],
                    fit: BoxFit.cover,
                  );
                },
                onPageChanged: (int index) {
                  _pageIndexNotifier.value = index;
                },
                clipBehavior: Clip.none, // Tambahkan clipBehavior di sini
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.bottomCenter,
              child: CirclePageIndicator(
                selectedDotColor: Colors.blue,
                dotColor: Colors.grey,
                itemCount: _imagePaths.length,
                currentPageNotifier: _pageIndexNotifier,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Explore all the most exciting courses based on your interest and study major",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginRegister()));
              },
              child: Container(
                width: 200,
                height: 60,
                child: Center(
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
