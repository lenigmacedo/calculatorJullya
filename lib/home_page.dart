import 'package:calculator_jullya/widgets/background.dart';
import 'package:calculator_jullya/widgets/cards_materia.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(50, Colors.purple, rankKey: 'sucess'),
        new CircularSegmentEntry(50, Colors.purple[300], rankKey: 'error'),
      ],
      rankKey: 'geral',
    ),
  ];

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Background(),
            TabBar(
              labelColor: Colors.black,
              indicatorWeight: 2,
              labelPadding: EdgeInsets.only(bottom: 10, top: 10),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle:
                  GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
              indicatorColor: Colors.purple,
              tabs: [
                Text("Porcentagem geral"),
                Text("Porcentagem Matéria"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: AnimatedCircularChart(
                      duration: Duration(milliseconds: 1000),
                      chartType: CircularChartType.Pie,
                      size: Size(350.0, 350.0),
                      initialChartData: data,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView(
                      children: <Widget>[
                        CardMateria(
                          materia: 'Matemática',
                          porcentagem: 80,
                        ),
                        CardMateria(
                          materia: 'Português',
                          porcentagem: 80,
                        ),
                        CardMateria(
                          materia: 'Química',
                          porcentagem: 80,
                        ),
                        CardMateria(
                          materia: 'Física',
                          porcentagem: 80,
                        ),
                        CardMateria(
                          materia: 'História',
                          porcentagem: 80,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
