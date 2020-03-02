import 'package:calculator_jullya/detail_screen.dart';
import 'package:calculator_jullya/services/database.dart';
import 'package:calculator_jullya/widgets/background.dart';
import 'package:calculator_jullya/widgets/cards_materia.dart';
import 'package:calculator_jullya/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/materia.dart';

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

  List materiasModel = <Materia>[];
  String semana;
  bool teste;

  List materias = [
    'Gramática',
    'Texto',
    'Literatura',
    'Matemática',
    'História',
    'Geografia',
    'Biologia',
    'Física',
    'Química'
  ];

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
                head: Profile(
                  getSemana: getSemana,
                  refresh: refresh,
                ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset('lib/assets/deus.png'),
                  ),

                  // Center(
                  //   child: AnimatedCircularChart(
                  //     duration: Duration(milliseconds: 1000),
                  //     chartType: CircularChartType.Pie,
                  //     size: Size(350.0, 350.0),
                  //     initialChartData: data,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RefreshIndicator(
                      color: Colors.white,
                      onRefresh: refresh,
                      child: ListView(
                          children: materiasModel.map((f) {
                        return CardMateria(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        erros: f.erros,
                                        total: f.total,
                                        materia: f.materia,
                                        acertos: f.acertos,
                                        semana: semana,
                                      ))),
                          materia: f.materia,
                          porcentagem: f.acertos * 100 ~/ f.total,
                        );
                      }).toList()),
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

  getSemana(value) {
    semana = value;
  }

  Future<Null> refresh() async {
    getPercent();
    return null;
  }

  getPercent() {
    var auxSemana = semana.replaceAll(' ', '').toLowerCase();
    materias.forEach((f) {
      materiasModel = [];
      setState(() {});
      LocalDatabase.db.select(auxSemana, f).then((response) {
        List data = response;

        data.forEach((f) {
          materiasModel.add(
              (Materia(f['materia'], f['total'], f['erros'], f['acerto'])));
          setState(() {});
        });
      });
    });
  }
}
