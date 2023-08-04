import 'package:flutter/material.dart';
import 'package:plantapp/preference_service.dart';

class OutdoorPlants extends StatefulWidget {
  const OutdoorPlants({super.key});

  @override
  State<OutdoorPlants> createState() => _OutdoorPlantsState();
}

class _OutdoorPlantsState extends State<OutdoorPlants> {
  final List<String>? plantNames2 = PreferencesService.sharedPreferencesInstance.getStringList('plantNames2');
  final List<String>? plantLocations2 = PreferencesService.sharedPreferencesInstance.getStringList('plantLocations2');
  final List<String>? buyingDates2 = PreferencesService.sharedPreferencesInstance.getStringList('buyingDates2');
  @override
  Widget build(BuildContext context) {
    if (plantNames2 == null || plantNames2!.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Outdoor Plants"),
            centerTitle: true,
          ),
          body: const Center(child: Text('No plants added yet')));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indoor Plants'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: plantNames2!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.sunny, color: Colors.green[800]),
                  title: Text(plantNames2![index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(plantLocations2![index]),
                  trailing: Text(buyingDates2![index]),
                  onLongPress: () {
                    setState(() {
                      plantNames2!.removeAt(index);
                      plantLocations2!.removeAt(index);
                      buyingDates2!.removeAt(index);
                      PreferencesService.sharedPreferencesInstance.setStringList('plantNames2', plantNames2!);
                      PreferencesService.sharedPreferencesInstance.setStringList('plantLocations2', plantLocations2!);
                      PreferencesService.sharedPreferencesInstance.setStringList('buyingDates2', buyingDates2!);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
