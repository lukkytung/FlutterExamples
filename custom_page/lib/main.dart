import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPicker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
            ],
          ),
          title: Text('Numberpicker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
            _DecimalExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Default', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          haptics: true,
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentIntValue - 10;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current int value: $_currentIntValue'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentIntValue + 20;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
        Divider(color: Colors.grey, height: 32),
        SizedBox(height: 16),
        Text('Horizontal', style: Theme.of(context).textTheme.headline6),
        Stack(alignment: Alignment.center, children: [
          Container(
            width: 50,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Colors.black26),
            ),
          ),
          NumberPicker(
            value: _currentHorizontalIntValue,
            minValue: 1,
            maxValue: 180,
            step: 1,
            itemCount: 7,
            itemHeight: 36,
            itemWidth: 48,
            infiniteLoop: true,
            haptics: true,
            axis: Axis.horizontal,
            onChanged: (value) {
              setState(() => _currentHorizontalIntValue = value);
            },
            textStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 16,
            ),
            selectedTextStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Colors.black26),
            ),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue - 10;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current horizontal int value: $_currentHorizontalIntValue'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue + 1;
                _currentHorizontalIntValue = newValue.clamp(1, 180);
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecimalExample extends StatefulWidget {
  @override
  __DecimalExampleState createState() => __DecimalExampleState();
}

class __DecimalExampleState extends State<_DecimalExample> {
  double _currentDoubleValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Decimal', style: Theme.of(context).textTheme.headline6),
        DecimalNumberPicker(
          value: _currentDoubleValue,
          minValue: 0,
          maxValue: 10,
          decimalPlaces: 2,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
