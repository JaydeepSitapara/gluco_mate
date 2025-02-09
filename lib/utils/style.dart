import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle montserratStyle({
  double? fontSize,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
