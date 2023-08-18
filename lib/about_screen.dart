import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://ko-fi.com/thebuffed');

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
                "Hi, I'm Eric Davidson, and I created the first version of this app years ago just to provide a helpful tool to a community that I love so much."),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
                "The most recent update was a move to a new app framework so that will allow me to actually release updates, because the previous framework was not meant for ongoing development."),
          ),
          Container(
              child: Image.asset(
            'assets/me.jpg',
            width: 150,
            height: 150,
          )),
          GestureDetector(
            onTap: () {
              launchUrl(_url); // Replace with your link URL
            },
            child: Image.asset(
              'assets/kofi3.png', // Replace with your image asset path
              width: 150,
              height: 70,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
                "Projects like this fill my heart with joy, and I will never show advertisements or hide functionality behind a paywall (Although, there wouldn't be much to hide!)\n\nI've added a donation link in case you ever feel like sharing a cup of coffee. Thank you, and good luck with your projects!"),
          ),
        ],
      ),
    );
  }
}
