import 'package:calculator_jullya/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Color fundo = Color(0xFF131A40);
  Color otoFundo = Color(0xFF355B8C);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Jullyinha notas',
      theme: ThemeData(canvasColor: fundo),
      home: DefaultTabController(
        length: 2,
        child: HomePage(),
      ),
    );
  }
}
