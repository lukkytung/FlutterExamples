import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'models/car.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Realm realm;

  _MyAppState() {
    final config = Configuration.local([Car.schema, Person.schema]);
    realm = Realm(config);
  }

  int get carsCount => realm.all<Car>().length;

  @override
  void initState() {
    super.initState();
    var myCar = Car(ObjectId(), 'Tesla', model: 'Model S', kilometers: 42);
    realm.write(() {
      print('Adding a Car to Realm.');
      var car = realm
          .add(Car(ObjectId(), 'Tesla', owner: Person(ObjectId(), 'Lukky')));
      print("Updating the car's model and kilometers");
      car.model = "Model 3";
      car.kilometers = 5000;

      print('Adding another Car to Realm.');
      realm.add(myCar);

      print("Changing the owner of the car.");
      myCar.owner = Person(ObjectId(), "John", age: 18);
      print("The car has a new owner ${car.owner!.name}");
    });

    print("Getting all cars from the Realm.");
    var cars = realm.all<Car>();
    print("There are ${cars.length} cars in the Realm.");

    var indexedCar = cars[0];
    print('The first car is ${indexedCar.make} ${indexedCar.model}');

    print("Getting all Tesla cars from the Realm.");
    var filteredCars = realm.all<Car>().query("make == 'Tesla'");
    print('Found ${filteredCars.length} Tesla cars');

    realm.write(() => realm.delete(filteredCars[0]));
    print('Deleted car');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realm Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Realm Demo'),
        ),
        body: Center(
          child: Text(
              'Running on: ${Platform.operatingSystem}.\n\nThere are $carsCount cars in the Realm.\n'),
        ),
      ),
    );
  }
}
