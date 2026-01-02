import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
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
            bodyFlex: 3,
            imageFlex: 3,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                Lottie.asset(
                  "assets/lottie/Map.json",
                  width: 100,
                  height: 100
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome To Vibe Finder",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Find Places That Match Your Vibe",
             style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          image: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                "assets/images/back3.jpg",
                fit: BoxFit.cover,
              ),
             
              
             
              Positioned(
                
                top: 120,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/images/mainlogo.png"),
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
    bodyFlex: 2,
    imageFlex: 3,
  ),
  titleWidget: Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
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
        "assets/images/back3.jpg",
        fit: BoxFit.cover,
      ),
     
      // Lottie animation at the top
    
      // CircleAvatar below the Lottie
      Positioned(
        top: 180,  // Adjusted to be below Lottie
        left: 0,
        right: 0,
        child: CircleAvatar(
          radius: 130,
         backgroundColor: Color.fromARGB(255, 183, 196, 100),
          child: Lottie.asset(
          "assets/lottie/reactionfeel.json",
         
          fit: BoxFit.fill,
          )
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
            bodyFlex: 4,
            imageFlex: 4,
          ),
          titleWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Finds Places Near You, Instantly",
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
                "assets/images/back3.jpg",
                fit: BoxFit.cover,
              ),
             
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 176, 190, 84),
                    radius: 150,
                   child: Lottie.asset("assets/lottie/user.json"),
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
    bodyFlex: 0,
    imageFlex: 1,
  ),
  titleWidget: SizedBox.shrink(),
  bodyWidget: SizedBox.shrink(),
  image: Stack(
    fit: StackFit.expand,
    children: [
      Image.asset(
        "assets/images/mapbackground.jpg",
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.2),
      ),
      Padding(
        padding: EdgeInsets.only(top: 60), // Adjust this value for top spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Changed to start
          children: [
            CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage("assets/images/maps.avif"),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "See It on the Map",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Tap a place and view it instantly on the map. \nNavigate, explore, and vibe your way around the city.",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
      skip: Container(
        height: 35,
        width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
             color: Colors.white,
          ),
        child: Center(child: Text("Skip", style: Theme.of(context).textTheme.bodySmall))),
      next:
        CircleAvatar(
          backgroundColor: Colors.white,
          child:Icon(Icons.arrow_forward, color: Colors.black, size: 25,), 
        ),
       
      done: Container(
        width: 65,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white
        ),
        child: Center(child: Text("Done", style: Theme.of(context).textTheme.bodySmall))),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}