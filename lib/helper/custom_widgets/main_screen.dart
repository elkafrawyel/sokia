import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String title;
  final Color pageBackground;
  final Widget body;
  final Key key;

  MainScreen({
    this.key,
    this.title,
    this.pageBackground,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          centerTitle: true,
          brightness: Brightness.dark,
        ),
        backgroundColor: pageBackground,
        body: body);
  }
}
