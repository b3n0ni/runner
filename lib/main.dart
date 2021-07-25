import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:runner/game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  imageCache.clear();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run Bob',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Run bob'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DinoGame game;

  @override
  void initState() {
    super.initState();
    game = DinoGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: game.widget);
  }
}
