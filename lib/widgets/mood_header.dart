import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MoodHeader extends StatelessWidget {
  final String currentMood;
  final Color defaultColor;

  const MoodHeader({
    super.key,
    required this.currentMood,
    required this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
      
        borderRadius: BorderRadius.circular(20),
        border: Border.all()
       
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Hey There!!! \nUser \nWelcome", 
              style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              SizedBox(
                height: 150,
                width: 150,
                child: LottieBuilder.asset("assets/lottie/Welcome.json"))
            ],
          ),
          SizedBox(height: 16),
          
        ],
      ),
    );
  }
}
