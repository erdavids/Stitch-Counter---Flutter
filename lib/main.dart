import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'theme_choice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = lightTheme; // Default theme is light theme

  void _changeTheme(ThemeData newTheme) {
    setState(() {
      themeData = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        changeTheme: _changeTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.changeTheme})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Function(ThemeData) changeTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'CustomFont',
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'CustomFont',
);

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isRowCountShown = false;

  void _navigateToAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutScreen()),
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _toggleRowCount(bool newValue) {
    setState(() {
      _isRowCountShown = newValue;
    });
  }

  void _navigateToThemeSelection(BuildContext context) async {
    ColorPair selectedColorPair = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThemeSelectionScreen(
          colorPairs: [
            ColorPair(Colors.blue, Colors.blueAccent),
            ColorPair(Colors.green, Colors.greenAccent),
            ColorPair(Colors.red, Colors.redAccent),
          ],
          onThemeSelected: (colorPair) {
            Navigator.pop(context, colorPair); // Pass the selected color pair as the result
          },
        ),
      ),
    );

    if (selectedColorPair != null) {
      // Apply the selected theme
      // ThemeData newTheme = ThemeData(
      //   primaryColor: selectedColorPair.primary,
      //   accentColor: selectedColorPair.secondary,
      // );
      // _applyTheme(newTheme);
    }
  }

  void _handleOption(String value) {
    if (value == 'dark_theme') {
      widget.changeTheme(darkTheme);
    } else if (value == 'about') {
      _navigateToAboutScreen();
    } else if (value == 'theme') {
      _navigateToThemeSelection(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'showRowCount') {
                _toggleRowCount(!_isRowCountShown);
              } else {
                _handleOption(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                CheckedPopupMenuItem(
                  value: 'showRowCount',
                  checked: _isRowCountShown,
                  child: const Text('Show Row Count'),
                ),
                const PopupMenuItem<String>(
                  value: 'light_theme',
                  child: Text('Light Theme'),
                ),
                const PopupMenuItem<String>(
                  value: 'dark_theme',
                  child: Text('Dark Theme'),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Text('About'),
                ),
                const PopupMenuItem<String>(
                  value: 'theme',
                  child: Text('Theme Choice'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _counter++;
                });
              },
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 148,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 148,
                    ),
                  ),
                ),
                const Spacer(), // Add some spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 148,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
