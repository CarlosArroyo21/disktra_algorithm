// ignore_for_file: file_names

class Route {
  final String destination;
  final int distance;

  Route({required this.destination, required this.distance});
}

class City {
  final String name;
  late List<Route> linkedRoutes;

  City({required this.name, this.linkedRoutes = const []});
}


final cities = [
  City(
    name: "Galapa",
    linkedRoutes: [
      Route(
        destination: "Medellín",
        distance: 700
      ),  
      Route(
        destination: "Bucaramanga",
        distance: 600
      ),
    ]
  ),
  
  City(
    name: "Medellín",
    linkedRoutes: [
      Route(
        destination: "Galapa",
        distance: 700
      ),
      Route(
        destination: "Bucaramanga",
        distance: 380
      ),
      Route(
        destination: "Bogotá",
        distance: 410
      ),
      Route(
        destination: "Pereira",
        distance: 200
      ),
      Route(
        destination: "Cali",
        distance: 400
      ),
    ]
  ),

  City(
    name: "Bucaramanga",
    linkedRoutes: [
      Route(
        destination: "Galapa",
        distance: 600
      ),
      Route(
        destination: "Medellín",
        distance: 380
      ),
      Route(
        destination: "Bogotá",
        distance: 430
      ),
    ]
  ),

  City(
    name: "Bogotá",
    linkedRoutes: [
      Route(
        destination: "Bucaramanga",
        distance: 430
      ),
      Route(
        destination: "Medellín",
        distance: 410
      ),
      Route(
        destination: "Ibagué",
        distance: 200
      ),
    ]
  ),

  City(
    name: "Ibagué",
    linkedRoutes: [
      Route(
        destination: "Popayán",
        distance: 470
      ),
      Route(
        destination: "Cali",
        distance: 300
      ),
      Route(
        destination: "Pereira",
        distance: 110
      ),
      Route(
        destination: "Bogotá",
        distance: 200
      ),
    ]
  ),

  City(
    name: "Pereira",
    linkedRoutes: [
      Route(
        destination: "Ibagué",
        distance: 110
      ),
      Route(
        destination: "Medellín",
        distance: 200
      ),
      Route(
        destination: "Cali",
        distance: 200
      ),
    ]
  ),

  City(
    name: "Cali",
    linkedRoutes: [
      Route(
        destination: "Ibagué",
        distance: 300
      ),
      Route(
        destination: "Pereira",
        distance: 200
      ),
      Route(
        destination: "Medellín",
        distance: 400
      ),
      Route(
        destination: "Popayán",
        distance: 130
      ),
    ]
  ),

  City(
    name: "Popayán",
    linkedRoutes: [
      Route(
        destination: "Ibagué",
        distance: 470
      ),
      Route(
        destination: "Cali",
        distance: 130
      ),
    ]
  ),
];