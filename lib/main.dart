import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => ConverterState();
}

class ConverterState extends State<Converter> {

  final Map<String, List<String>> unitCategories = {
    'Length': ['Meters', 'Kilometers', 'Miles', 'Feet'],
    'Weight': ['Kilograms', 'Grams', 'Pounds', 'Ounces'],
    'Speed': ['Meters/Second', 'Kilometers/Hour', 'Miles/Hour'],
    'Volume': ['Liters', 'Milliliters', 'Cubic Meters', 'Gallons'],
  };

  double? userInput;
  String selectedCategory = 'Length';
  String fromUnit = 'Meters';
  String toUnit = 'Kilometers';
  String result = '';

  // Conversion Rates
  final Map<String, Map<String, double>> conversionRates = {
    'Length': {
      'Meters-Kilometers': 0.001,
      'Kilometers-Meters': 1000,
      'Meters-Miles': 0.000621371,
      'Miles-Meters': 1609.34,
      'Feet-Meters': 0.3048,
      'Meters-Feet': 3.28084,
    },
    'Weight': {
      'Kilograms-Grams': 1000,
      'Grams-Kilograms': 0.001,
      'Kilograms-Pounds': 2.20462,
      'Pounds-Kilograms': 0.453592,
    },
    'Speed': {
      'Meters/Second-Kilometers/Hour': 3.6,
      'Kilometers/Hour-Meters/Second': 0.277778,
      'Miles/Hour-Kilometers/Hour': 1.60934,
      'Kilometers/Hour-Miles/Hour': 0.621371,
    },
    'Volume': {
      'Liters-Milliliters': 1000,
      'Milliliters-Liters': 0.001,
      'Liters-Gallons': 0.264172,
      'Gallons-Liters': 3.78541,
    },
  };

  void convert() {
    final key = '$fromUnit-$toUnit';

    if (conversionRates[selectedCategory]?.containsKey(key) ?? false) {
      final rate = conversionRates[selectedCategory]![key]!;
      setState(() {
        result = '${(userInput! * rate).toStringAsFixed(2)} $toUnit';
      });
    } else {
      setState(() {
        result = 'Conversion not available.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(181, 192, 192, 192),
      appBar: AppBar(
      title: const Text("Units Converter"),
      centerTitle: true, 
      backgroundColor: const Color.fromARGB(181, 8, 56, 59), 
      titleTextStyle: const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 175, 189, 197), 
               ),
                   ),
     
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                    fromUnit = unitCategories[selectedCategory]!.first;
                    toUnit = unitCategories[selectedCategory]!.first;
                  });
                },
                 style: const TextStyle(
                       color: Colors.teal, 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        ),
                    dropdownColor: Colors.amberAccent, 
                     underline: Container(
                       height: 2,
                        color: Colors.teal, 
                        ),  
                items: unitCategories.keys
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
           
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter value',
                  hintStyle: TextStyle(color: Color.fromARGB(185, 158, 158, 158)),
                  filled: true,
                  fillColor: Color.fromARGB(181, 255, 255, 255),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), )
                ),
                onChanged: (value) {
                  setState(() {
                    userInput = double.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 16),


              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: fromUnit,
                      onChanged: (value) {
                        setState(() {
                          fromUnit = value!;
                        });
                      },
                       style: const TextStyle(
                       color:Color.fromARGB(226, 8, 56, 59), 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        ),
                      
                      items: unitCategories[selectedCategory]!
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 32),
                  Expanded(
                    child: DropdownButton<String>(
                      value: toUnit,
                      onChanged: (value) {
                        setState(() {
                          toUnit = value!;
                        });
                      },
                      style: const TextStyle(
                       color:Color.fromARGB(226, 8, 56, 59), 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        ),
                      items: unitCategories[selectedCategory]!
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (userInput != null) {
                    convert();
                  } else {
                    setState(() {
                      result = 'Please enter a valid number.';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.teal, 
                 foregroundColor: Colors.white,
  
                 ),
               child: const Text(
                 'Convert',
                   style: TextStyle(
                      fontSize: 18, 
                       fontWeight: FontWeight.bold, 
                     ),
                        ),
                   ),
              const SizedBox(height: 16),
             
              Text(
                'Result: $result',
                style:const TextStyle(fontSize: 22, color:  Color.fromARGB(255, 83, 57, 47), fontWeight: FontWeight.bold ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
