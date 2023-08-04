import 'package:flutter/material.dart';
import 'package:plantapp/preference_service.dart';
import 'package:plantapp/pages/reminder.dart';

class IndoorPlants extends StatefulWidget {
  const IndoorPlants({super.key});

  @override
  State<IndoorPlants> createState() => _IndoorPlantsState();
}

class _IndoorPlantsState extends State<IndoorPlants> {
  final List<String>? plantNames = PreferencesService.sharedPreferencesInstance.getStringList('plantNames');
  final List<String>? plantLocations = PreferencesService.sharedPreferencesInstance.getStringList('plantLocations');
  final List<String>? buyingDates = PreferencesService.sharedPreferencesInstance.getStringList('buyingDates');
  @override
  Widget build(BuildContext context) {
    if (plantNames == null || plantNames!.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Indoor Plants"),
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
            itemCount: plantNames!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.eco, color: Colors.green[800]),
                  title: Text(plantNames![index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(plantLocations![index]),
                  trailing: Text(buyingDates![index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderForm(
                          index: index,
                          plantName: plantNames![index],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    setState(() {
                      plantNames!.removeAt(index);
                      plantLocations!.removeAt(index);
                      buyingDates!.removeAt(index);
                      PreferencesService.sharedPreferencesInstance.setStringList('plantNames', plantNames!);
                      PreferencesService.sharedPreferencesInstance.setStringList('plantLocations', plantLocations!);
                      PreferencesService.sharedPreferencesInstance.setStringList('buyingDates', buyingDates!);
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
