import 'package:flutter/material.dart';
import 'package:untitled/layouts/bottomNavigationBar.dart';
// import 'package:flutter_basic/layouts/columns_row.dart';
// import 'package:flutter_basic/layouts/sample_container.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _text = 'Ini Adalah StatefulWidget';

  void _changeText() {
    setState(() {
      _text = 'Text Telah Berubah';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Bottom Navigation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            ElevatedButton(
              onPressed: _changeText,
              child: const Text(
                'Ubah text',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    letterSpacing: 2,
                    wordSpacing: 5,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: MyBottonNavigation(),
    ),
  );
}
