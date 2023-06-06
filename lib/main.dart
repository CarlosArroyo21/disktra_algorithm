
import 'package:disktra_algorithm/Routes.dart' as routes_data;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Alpina Rutas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<routes_data.City> newCities;
  String? sourceCity, destinationCity;
  double bestDistance = double.nan;
  List<String> route = [];

  @override
  void initState() {
    newCities = routes_data.cities;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Container(
                color: Colors.blueAccent,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 100.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  //Source city's comboBox
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ciudad origen"),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        hint: const Text("Ciudad origen..."),
                        value: sourceCity,
                        items: newCities.map<DropdownMenuItem>((city) => DropdownMenuItem(
                          enabled: city.name != sourceCity && city.name != destinationCity,
                          value: city.name,
                          child: Text(city.name))).toList(),
                        onChanged: (chosenCity) {
                          setState(() {
                            sourceCity = chosenCity;
                          });
                        },
                      ),
                    ],
                  ),

                  //Destination city's comboBox
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ciudad Destino"),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        hint: const Text("Ciudad destino..."),
                        value: destinationCity,
                        items: newCities.map<DropdownMenuItem>((city) => DropdownMenuItem(
                          enabled: city.name != sourceCity && city.name != destinationCity,
                          value: city.name,
                          child: Text(city.name))).toList(),
                        onChanged: (chosenCity) {
                          setState(() {
                            destinationCity = chosenCity;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(
                height: 50,
              ),
              //Calculate best route's button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    calculateRoute();
                  });
                  
                }, 
                child: const Text(
                  "Calcular mejor ruta",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              Text(
                bestDistance.isNaN
                ? ""
                : "La mejor ruta es: ${printRoute()} con $bestDistance Km."
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  calculateRoute() {
    
    List<double> distance = List<double>.filled(routes_data.cities.length, double.infinity);
    int sourceCityIndex = routes_data.cities.indexWhere((city) => city.name == sourceCity);
    distance[sourceCityIndex] = 0;
    List<List<String>> paths = List<List<String>>.filled(routes_data.cities.length, List.empty(growable: true));
    paths[sourceCityIndex] = [routes_data.cities.elementAt(sourceCityIndex).name];
    List<int> priorityQueue = [sourceCityIndex];

    while (priorityQueue.isNotEmpty) {

      priorityQueue.sort((cityA, cityB) => distance[cityA].compareTo(distance[cityB]));
      
      int currentCityIndex = priorityQueue.removeAt(0);

      for (routes_data.Route route in routes_data.cities[currentCityIndex].linkedRoutes) {
        
        int nextCityindex = routes_data.cities.indexWhere((city) => city.name == route.destination);
        double newDistance = distance[currentCityIndex] + route.distance;

        if (newDistance < distance[nextCityindex]) {

          distance[nextCityindex] = newDistance;

          priorityQueue.add(nextCityindex);

          paths[nextCityindex] = List<String>.from(paths[currentCityIndex])..add(routes_data.cities[nextCityindex].name);
        }
      }
    }
    
    int destinationCityIndex = routes_data.cities.indexWhere((city) => city.name == destinationCity);
    bestDistance = distance[destinationCityIndex];
    route = paths[destinationCityIndex];

  }

  String printRoute() {

    if(route.isNotEmpty) {
      return route.reduce((value, element) => "$value -> $element");
    }

    return ""; 
  }
}
