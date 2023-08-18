import 'package:flutter/material.dart';

class ColorPair {
  final Color primary;
  final Color secondary;

  ColorPair(this.primary, this.secondary);
}
class ThemeSelectionScreen extends StatelessWidget {
  final List<ColorPair> colorPairs;
  final Function(ColorPair) onThemeSelected;

  ThemeSelectionScreen({
    required this.colorPairs,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Theme'),
      ),
      body: ListView.builder(
        itemCount: colorPairs.length,
        itemBuilder: (context, index) {
          ColorPair colorPair = colorPairs[index];
          return ListTile(
            title: Row(
              children: [
                Text('Theme ${index + 1}'),
                SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 20,
                  color: colorPair.primary,
                ),
                SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 20,
                  color: colorPair.secondary,
                ),
              ]
            ),
            onTap: () {
              onThemeSelected(colorPair);
            },
          );
        },
      ),
    );
  }
}