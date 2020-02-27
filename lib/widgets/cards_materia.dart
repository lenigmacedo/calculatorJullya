import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMateria extends StatefulWidget {
  @override
  _CardMateriaState createState() => _CardMateriaState();

  String materia;
  int porcentagem;

  CardMateria({@required this.materia, @required this.porcentagem}) : super();
}

class _CardMateriaState extends State<CardMateria> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Container(
        height: 80,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.materia,
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '${widget.porcentagem}%',
                  style: GoogleFonts.lato(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
