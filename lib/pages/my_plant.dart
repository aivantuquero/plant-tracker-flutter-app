import 'package:flutter/material.dart';
import 'package:plantapp/pages/indoor_plants.dart';
import 'package:plantapp/pages/outdoor_plants.dart';

class MyPlant extends StatelessWidget {
  const MyPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 325,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/indoor.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(children: [
                      const Text(
                        "Indoor Plants",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Your plants that lives indoor. They can boost moods, increase creativity, and reducr stress."),
                      ElevatedButton(
                        // gawin mo tong async tapos
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const IndoorPlants()));
                        },
                        child: const Text('View All'),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 325,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/outdoor.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          "Outdoor Plants",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Your plants that need low maintenance and grow up easily on the outside are known as Outdoor plants."),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OutdoorPlants()));
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
