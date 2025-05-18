import 'package:fancy_radio_buttons/fancy_radio_buttons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FancyRadioButton(
            headerTitle: "Testing",
            itemActiveColor: Colors.red,
            initialSelectedItemIndex: 2,
            items: [
              ButtonItem(key: "one", title: "One"),
              ButtonItem(key: "two", title: "Two"),
              ButtonItem(key: "three", title: "Three", isEnabled: false),
            ],
            onSelection: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
