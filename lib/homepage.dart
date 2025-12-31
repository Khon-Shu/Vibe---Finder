import 'package:flutter/material.dart';
import 'package:vibefinder/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedindex = 0;
  List<Widget> _optionWidgets =<Widget>[

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vibe Finder",
        style: Theme.of(context).textTheme.titleLarge,
        ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Text("Enter Your Mode for Today:"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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