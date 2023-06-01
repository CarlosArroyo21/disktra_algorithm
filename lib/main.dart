
import 'package:disktra_algorithm/Routes.dart' as d;
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
  late List<d.City> newCities;
  String? sourceCity, destinationCity;

  @override
  void initState() {
    // TODO: implement initState
    newCities = d.cities;
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
                  calculateRoute();
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
              const Text("La mejor ruta es")
            ],
          ),
        ),
      ),
    );
  }
  
  calculateRoute() {
    /*
    1. We obtain the source city.
    2. We initialize a acumulated distance variable with 0.
    3. We iterate within its linked routes
    4. We sum the acum distance and we have to save the result of each route's
    distance sum to compare them later and set the priority city to evaluate after.
    5. 
    
    */
    
    List<String> priorityQueue = [];
    Map<String, int> cityDistances = {};
    var citiesEvaluated = <String>[];
    d.City initialCity = newCities.firstWhere((city) => city.name == sourceCity);
    while (citiesEvaluated.length < newCities.length) {
      
      if(!citiesEvaluated.contains(initialCity.name)) {
        citiesEvaluated.add(initialCity.name);
      }

      for (var route in initialCity.linkedRoutes) {

        if (!cityDistances.containsKey(route.destination)) {
          cityDistances[route.destination] = route.distance;
        } else {
          cityDistances[route.destination] = cityDistances[route.destination]! + route.distance;
        }

        if (priorityQueue.isEmpty) {
          priorityQueue.add(route.destination);
        } else {

          int index = 0;
          cityDistances.forEach((key, value) {
            if (route.distance > value) {
              index++;
            }
          });
        }
      }

    }


   
    

    


    
  }
}
