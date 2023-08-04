import 'package:flutter/material.dart';
import 'package:plantapp/pages/my_plant.dart';
import 'package:plantapp/pages/add_plant.dart';
import 'package:plantapp/pages/reminders.dart';
import 'package:plantapp/preference_service.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavigationBarExample(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.grey,
        brightness: Brightness.light,
        dividerColor: Colors.green,
        fontFamily: 'Montserrat',
      ),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    PreferencesService.init();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.eco_outlined),
            Text('PlantTrackr'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 1000),
        indicatorColor: Colors.green[600],
        height: 60,
        indicatorShape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grass),
            label: 'My Plants',
          ),
          NavigationDestination(
            icon: Icon(Icons.forest),
            label: 'Add Plant',
          ),
          NavigationDestination(
            icon: Icon(Icons.shower),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'About',
          )
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
        const MyPlant(),
        const AddPlantForm(),
        const Reminders(),
        const About(),
      ][currentPageIndex],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Made by: Group 7", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
          SizedBox(height: 10),
          Text("Aivan Carlos B. Tuquero"),
          Text("Erwin G. Ceno"),
          Text("Julian, Shaira May J."),
          Text("Karriza A. Reyes"),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
