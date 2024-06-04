// ------- List of Colors ------- \\

import 'package:flutter/material.dart';

const vPrimaryColor = Color(0xFF2da6bf);
const vSecondaryColor = Color(0xFF015571);
const vTertiaryColor = Color(0xFF73c4d4);
const vQuaternaryColor = Color(0xFFf0dcd6);
const vQuintenaryColor = Color(0xFF96d2df);
const vAccentColor = Color(0xFF12424c);
const vTitleColor = Color(0xFFffffff);
const vDefaultGrayL = Color(0xFFC8C8C8);
const vDefaultGrayD = Color(0xFF9C9C9C);

final vCardBgLightColor = const Color(0xFFffffff).withOpacity(0.5);
final vCardBgDarkColor = const Color(0xFF1e1e1e).withOpacity(0.5);
final vFormBgLightColor = const Color(0xFFffffff).withOpacity(0.3);
final vFormBgDarkColor = const Color(0xFF1e1e1e).withOpacity(0.3);
const vLightColor = Color(0xFFffffff);
const vDarkColor = Color(0xFF1e1e1e);

const vAlertColor = Color(0xFFF4980E);

// ------- List of gradients------- \\

const bgLightGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.03, 0.08, 0.24, 0.36, 0.42, 0.58],
  colors: [
    Color(0xFF12424c),
    Color(0xFF015571),
    Color(0xFF1fa7c2),
    Color(0xFFbbc9d1),
    Color(0xFFf0dcd6),
    Color(0xFFffffff),
  ],
);
const bgDarkGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.03, 0.08, 0.24, 0.36, 0.42, 0.58],
  colors: [
    Color(0xFF00222c),
    Color(0xFF012835),
    Color(0xFF104954),
    Color(0xFF454D51),
    Color(0xFF3f3938),
    Color(0xFF1e1e1e),
  ],
);
const bgLightGradientHeaderBig = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.009, 0.10, 0.40, 0.58, 0.72, 0.95],
  colors: [
    Color(0xFF12424c),
    Color(0xFF015571),
    Color(0xFF1fa7c2),
    Color(0xFFbbc9d1),
    Color(0xFFf0dcd6),
    Color(0xFFffffff),
  ],
);
const bgDarkGradientHeaderBig = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.009, 0.10, 0.40, 0.58, 0.72, 0.95],
  colors: [
    Color(0xFF00222c),
    Color(0xFF012835),
    Color(0xFF104954),
    Color(0xFF454D51),
    Color(0xFF3f3938),
    Color(0xFF1e1e1e),
  ],
);
final bottomLightGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0.10, 0.26, 0.52],
  colors: [
    const Color(0xFFffffff).withOpacity(0.1),
    const Color(0xFFffffff).withOpacity(0.3),
    const Color(0xFFffffff),
  ],
);
final bottomDarkGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0.10, 0.26, 0.52],
  colors: [
    const Color(0xFF1e1e1e).withOpacity(0.1),
    const Color(0xFF1e1e1e).withOpacity(0.3),
    const Color(0xFF1e1e1e),
  ],
);
