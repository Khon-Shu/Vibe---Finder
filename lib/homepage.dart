import 'package:flutter/material.dart';
import 'package:vibefinder/home.dart';
import 'package:vibefinder/main.dart';
import 'package:vibefinder/userpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedindex = 0;
  List<Widget> optionWidgets =[
    vibeFinderHome(),
    Userpage()
  ];

    void onTap(int index){
      setState(() {
        _selectedindex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vibe Finder",
        style: Theme.of(context).textTheme.titleLarge,
        ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      ),
   body: optionWidgets[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: onTap,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
           ),
        BottomNavigationBarItem(
          icon:Icon(Icons.people),
          label: "User"
          )
           
           ])
    );
  }
}
