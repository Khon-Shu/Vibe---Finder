import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vibefinder/homepage.dart';

class Launchpage extends StatelessWidget {
  const Launchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          decoration: PageDecoration(
            pageColor: Colors.transparent,
            imagePadding: EdgeInsets.zero,
            contentMargin: EdgeInsets.zero,
            fullScreen: true,
            bodyFlex: 1,
            imageFlex: 2,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Find Places That Match Your Vibe",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Your mood decides the destination \n Discover nearby places that feel just right for you.",
             style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          image: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                "assets/images/background3.jpg",
                fit: BoxFit.cover,
              ),
             
              Container(
              color: Colors.black.withOpacity(0.1),
             ),
             
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/images/landing1.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      
        PageViewModel(
          decoration: PageDecoration(
            pageColor: Colors.transparent,
            imagePadding: EdgeInsets.zero,
            contentMargin: EdgeInsets.zero,
            fullScreen: true,
            bodyFlex: 1,
            imageFlex: 2,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "How Are You Feeling Today?",
               style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Happy, stressed, relaxed, or energetic \nJust pick your mood and let us do the thinking.",
               style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          image: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/background3.jpg",
                fit: BoxFit.cover,
              ),
             Container(
              color: Colors.black.withOpacity(0.1),
             ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/images/landing2.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        PageViewModel(
          decoration: PageDecoration(
            pageColor: Colors.transparent,
            imagePadding: EdgeInsets.zero,
            contentMargin: EdgeInsets.zero,
            fullScreen: true,
            bodyFlex: 1,
            imageFlex: 2,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Places Near You, Instantly",
               style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "We use your location to find cafés, parks, sports spots \n and peaceful places around you.",
                style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          image: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/background3.jpg",
                fit: BoxFit.cover,
              ),
             Container(
              color: Colors.black.withOpacity(0.1),
             ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/images/landing4.jpg"),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        PageViewModel(
          decoration: PageDecoration(
            pageColor: Colors.transparent,
            imagePadding: EdgeInsets.zero,
            contentMargin: EdgeInsets.zero,
            fullScreen: true,
            bodyFlex: 1,
            imageFlex: 2,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "See It on the Map",
                 style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Tap a place and view it instantly on the map. \nNavigate, explore, and vibe your way around the city.",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          image: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/mapbackground.jpg",
                fit: BoxFit.cover,
              ),
             Container(
              color: Colors.black.withOpacity(0.1),
             ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/images/maps.avif"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      },
      showSkipButton: true,
      skip: Text("Skip", style: Theme.of(context).textTheme.bodySmall),
      next: Icon(Icons.arrow_forward, color: Colors.black, size: 25,),
      done: Text("Done", style: Theme.of(context).textTheme.bodySmall),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}