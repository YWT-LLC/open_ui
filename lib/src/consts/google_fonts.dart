/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Accessible fonts taken from https://material.io/blog/how-to-make-text-more-accessible
// Plus some ones we think are cute

/// alexBrush
const String alexBrush = 'alexBrush';

/// atkinsonHyperlegible
const String atkinsonHyperlegible = 'atkinsonHyperlegible';

/// fingerPaint
const String fingerPaint = 'fingerPaint';

/// lexend
const String lexend = 'lexend';

/// noto
const String noto = 'noto';

/// openSans
const String openSans = 'openSans';

/// pressStart2P
const String pressStart2P = 'pressStart2P';

/// readexPro
const String readexPro = 'readexPro';

/// roboto
const String roboto = 'roboto';

/// sourceCodePro
const String sourceCodePro = 'sourceCodePro';

/// All the [GoogleFonts] currently supported
final Map<String, TextStyle> googleStyles = <String, TextStyle>{
  alexBrush: GoogleFonts.alexBrush(),
  atkinsonHyperlegible: GoogleFonts.atkinsonHyperlegible(),
  fingerPaint: GoogleFonts.fingerPaint(),
  lexend: GoogleFonts.lexend(),
  noto: GoogleFonts.notoSans(),
  openSans: GoogleFonts.openSans(),
  pressStart2P: GoogleFonts.pressStart2p(),
  readexPro: GoogleFonts.readexPro(),
  roboto: GoogleFonts.roboto(),
  sourceCodePro: GoogleFonts.sourceCodePro(),
};

/// Passes [starter] to the [gFont]'s textStyle param
/// Returns [starter] if [gFont] is not found/supported
TextStyle fuseWithGFont({required TextStyle starter, required String gFont}) => switch (gFont) {
      alexBrush => GoogleFonts.alexBrush(textStyle: starter),
      atkinsonHyperlegible => GoogleFonts.atkinsonHyperlegible(textStyle: starter),
      fingerPaint => GoogleFonts.fingerPaint(textStyle: starter),
      lexend => GoogleFonts.lexend(textStyle: starter),
      noto => GoogleFonts.notoSans(textStyle: starter),
      openSans => GoogleFonts.openSans(textStyle: starter),
      pressStart2P => GoogleFonts.pressStart2p(textStyle: starter),
      readexPro => GoogleFonts.readexPro(textStyle: starter),
      roboto => GoogleFonts.roboto(textStyle: starter),
      sourceCodePro => GoogleFonts.sourceCodePro(textStyle: starter),
      _ => starter,
    };
