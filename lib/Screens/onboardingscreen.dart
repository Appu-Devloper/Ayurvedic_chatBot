
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                image: "assets/lottie/health_soln.json",
                title: "Welcome to Ayurveda Bot",
                description: "Get personalized Ayurvedic solutions for your health concerns.",
                theme: theme,
              ),
              buildPage(
                image: "assets/lottie/animationplant.json",
                title: "Natural Healing",
                description: "Find remedies using Ayurvedic herbs and traditional wisdom.",
                theme: theme,
              ),
              buildPage(
                image: "assets/lottie/chat_soln.json",
                title: "Chat & Get Solutions",
                description: "Ask your health questions and receive expert guidance instantly.",
                theme: theme,
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: theme.primaryColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                SizedBox(height: 20),
                isLastPage
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text("Get Started", style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _controller.jumpToPage(2),
                            child: Text("Skip", style: theme.textTheme.bodyLarge),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller.nextPage(
                                duration: Duration(milliseconds: 500), curve: Curves.easeInOut),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15),
                            ),
                            child: Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({required String image, required String title, required String description, required ThemeData theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(image, height: 250),
        SizedBox(height: 20),
        Text(title, style: theme.textTheme.headlineLarge),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(description, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }
}
