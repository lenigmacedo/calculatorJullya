import 'package:calculator_jullya/services/database.dart';
import 'package:calculator_jullya/widgets/background.dart';
import 'package:calculator_jullya/widgets/head_atualizar.dart';
import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AtualizarMedias extends StatefulWidget {
  @override
  _AtualizarMediasState createState() => _AtualizarMediasState();
}

class _AtualizarMediasState extends State<AtualizarMedias> {
  String materia;
  String semana;
  double acerto = 0;
  int total = 0;
  String teste;

  TextEditingController controllerAcertos = TextEditingController();
  TextEditingController controllerErros = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  Color primaryCollor = Color(0xFF131A40);
  Color secondaryCollor = Color(0xFF355B8C);

  @override
  Widget build(BuildContext context) {
    return DropdownBanner(
      navigatorKey: navigatorKey,
      child: Scaffold(
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
                  head: Center(
                    child: HeadAtualizar(
                      getMateria: getMateria,
                      getSemana: getSemana,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              validator: (text) {
                                if (text.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                              },
                              controller: controllerAcertos,
                              style: GoogleFonts.lato(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: secondaryCollor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryCollor),
                                ),
                                labelText: 'Quantidade de acertos',
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              controller: controllerErros,
                              validator: (text) {
                                if (text.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                              },
                              onChanged: (text) {
                                var totalDeAcertos =
                                    int.parse(controllerAcertos.text);
                                var totalDeErros = int.parse(text);

                                if (totalDeAcertos != null) {
                                  setState(() {
                                    total = totalDeAcertos + totalDeErros;
                                    acerto = totalDeAcertos * 100 / total;
                                  });
                                }
                              },
                              style: GoogleFonts.lato(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Quantidade de erros',
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: secondaryCollor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: secondaryCollor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: primaryCollor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Acerto',
                                        style: GoogleFonts.lato(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        '${acerto.toInt()}%',
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: secondaryCollor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Total',
                                        style: GoogleFonts.lato(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        total.toString(),
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 30, 80, 20),
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: primaryCollor,
                          child: Text(
                            "Salvar",
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (materia == null) {
                              DropdownBanner.showBanner(
                                duration: Duration(seconds: 2),
                                text: 'Escolha uma matéria para salvar',
                                color: secondaryCollor,
                                textStyle: GoogleFonts.lato(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            } else if (semana == null) {
                              DropdownBanner.showBanner(
                                duration: Duration(seconds: 2),
                                text: 'Escolha uma semana para salvar',
                                color: secondaryCollor,
                                textStyle: GoogleFonts.lato(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              if (_formKey.currentState.validate()) {
                                var auxSemana =
                                    semana.replaceAll(' ', '').toLowerCase();
                                LocalDatabase.db
                                    .insert(
                                        materia,
                                        total,
                                        int.parse(controllerAcertos.value.text),
                                        int.parse(controllerErros.value.text),
                                        auxSemana.toLowerCase().trim())
                                    .then((response) {
                                  if (response
                                      .toString()
                                      .contains('DatabaseException')) {
                                    confirmEdit();
                                  } else {
                                    DropdownBanner.showBanner(
                                      duration: Duration(seconds: 2),
                                      color: Colors.transparent,
                                      text: 'Adicionado ao banco de dados',
                                      textStyle: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white),
                                    );
                                    Future.delayed(Duration(milliseconds: 2500))
                                        .whenComplete(
                                            () => Navigator.of(context).pop());
                                  }
                                });
                              } else {
                                print('nvalido');
                              }
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmEdit() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Confirmar alteração"),
            titleTextStyle: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Tem certeza que deseja atualizar as questões da matéria de $materia?",
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 40,
                        width: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Sim",
                            style: GoogleFonts.lato(
                                fontSize: 20, color: Colors.white),
                          ),
                          color: primaryCollor,
                          onPressed: () {
                            LocalDatabase.db
                                .update(
                                    semana.replaceAll(' ', '').toLowerCase(),
                                    int.parse(controllerAcertos.value.text),
                                    int.parse(controllerErros.value.text),
                                    materia,
                                    total)
                                .then((response) {
                              if (response.toString().isNotEmpty) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 100,
                        height: 40,
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          borderSide: BorderSide(color: primaryCollor),
                          child: Text(
                            "Não",
                            style: GoogleFonts.lato(
                                fontSize: 20, color: primaryCollor),
                          ),
                          //color: primaryCollor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  getMateria(value) {
    materia = value;
    print(materia);
  }

  getSemana(value) {
    semana = value;
    print(semana);
  }
}
