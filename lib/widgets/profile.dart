import 'package:calculator_jullya/atualizar_medias.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  Function getSemana;
  Function refresh;
  Profile({this.getSemana, this.refresh}) : super();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List semanas = ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'];

  String semanaSelecionada;
  Color fundo = Color(0xFF131A40);
  Color otoFundo = Color(0xFF355B8C);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Hi, Jullya!",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Text(
                      "Você é muito linda sabia",
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 50),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: otoFundo,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AtualizarMedias()));
                  },
                  child: Text(
                    "Atualizar média",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: Text(
                    'Clique para escolher a semana',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  iconSize: 0,
                  isExpanded: true,
                  value: semanaSelecionada,
                  items: semanas
                      .map(
                        (semana) => DropdownMenuItem(
                          value: semana,
                          child: Text(
                            '$semana',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      semanaSelecionada = value;
                      widget.getSemana(value);
                      widget.refresh();
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
