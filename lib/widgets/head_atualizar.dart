import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadAtualizar extends StatefulWidget {
  Function getMateria;
  Function getSemana;

  HeadAtualizar({this.getMateria, this.getSemana}) : super();

  @override
  _HeadAtualizarState createState() => _HeadAtualizarState();
}

class _HeadAtualizarState extends State<HeadAtualizar> {
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
  List semanas = ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'];
  String materiaSelecionada;
  String semanaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Escolha a matéria e a semana que deseja atualizar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: Text(
                    'Clique para ver as matérias',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  iconSize: 0,
                  isExpanded: true,
                  value: materiaSelecionada,
                  items: materias
                      .map(
                        (materias) => DropdownMenuItem(
                          value: materias,
                          child: Text(
                            '$materias',
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
                      materiaSelecionada = value;
                      widget.getMateria(value);
                    });
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
