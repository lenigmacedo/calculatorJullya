import 'package:calculator_jullya/services/database.dart';
import 'package:calculator_jullya/widgets/background.dart';
import 'package:calculator_jullya/widgets/cards_materia.dart';
import 'package:calculator_jullya/widgets/profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    getPercentLiteratura();
    getPercentBio();
    getPercentFisica();
    getPercentMat();
  }

  int percentLit = 0;
  int percentBio = 0;
  int percentFisica = 0;
  int percentMat = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Hero(
              transitionOnUserGestures: true,
              tag: 'backgroundTag',
              child: Background(
                head: Profile(),
              ),
            ),
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
                          porcentagem: percentMat,
                          onTap: () {},
                        ),
                        CardMateria(
                          materia: 'Literatura',
                          porcentagem: percentLit,
                        ),
                        CardMateria(
                          materia: 'Biologia',
                          porcentagem: percentBio,
                        ),
                        CardMateria(
                          materia: 'Física',
                          porcentagem: percentFisica,
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

  getPercentLiteratura() {
    LocalDatabase.db.select('semana1').then((response) {
      int total = response[0]['total'];
      int acerto = response[0]['acerto'];
      var erros = response[0]['erros'];

      var aux = acerto * 100 / total;

      print(aux);

      setState(() {
        percentLit = aux.toInt();
      });
    });
  }

  getPercentMat() {
    LocalDatabase.db.select('semana1').then((response) {
      int total = response[1]['total'];
      int acerto = response[1]['acerto'];
      var erros = response[1]['erros'];

      var aux = acerto * 100 / total;

      print(aux);

      setState(() {
        percentMat = aux.toInt();
      });
    });
  }

  getPercentBio() {
    LocalDatabase.db.select('semana1').then((response) {
      int total = response[2]['total'];
      int acerto = response[2]['acerto'];
      var erros = response[2]['erros'];

      var aux = acerto * 100 / total;

      print(aux);

      setState(() {
        percentBio = aux.toInt();
      });
    });
  }

  getPercentFisica() {
    LocalDatabase.db.select('semana1').then((response) {
      int total = response[3]['total'];
      int acerto = response[3]['acerto'];
      var erros = response[3]['erros'];

      var aux = acerto * 100 / total;

      print(aux);

      setState(() {
        percentFisica = aux.toInt();
      });
    });
  }
}
