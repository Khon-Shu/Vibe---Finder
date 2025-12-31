import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';

class vibeFinderHome extends StatefulWidget {
  const vibeFinderHome({super.key});

  @override
  State<vibeFinderHome> createState() => _vibeFinderHomeState();
}

class _vibeFinderHomeState extends State<vibeFinderHome> {
   List<String> _moodlist =<String>[" 😊   Happy", " 😔   Sad", " 😟   Stressed", " ⚡   Energetic", " 😎   Relaxed"];
 late String _dropdownvalue ;


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownvalue = _moodlist.first;
  }
  @override
  Widget build(BuildContext context) {
    return 
 Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Enter Your Mood Today:", 
          style: Theme.of(context).textTheme.bodyLarge,
          )),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            height: 70,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              padding: EdgeInsets.all(8.0),
              focusColor: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(30),
              initialValue: _dropdownvalue,
              icon: Icon(Icons.arrow_downward),
              items: _moodlist.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                 child: Text(value,
                 style: Theme.of(context).textTheme.bodySmall,
                 ));
              }).toList(),
               onChanged: (String? newvalue){
                setState(() {
                 _dropdownvalue = newvalue!;
                context.read<VibeFinderProvider>().changeMood(newvalue);
            
                });
               }),
          ),
          const SizedBox(height: 25),
        Text("Your current Mood is:${context.watch<VibeFinderProvider>().currentmood}",
        style: Theme.of(context).textTheme.bodySmall,
        )
        ],
      );
}
}
