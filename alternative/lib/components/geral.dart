import 'package:flutter/cupertino.dart';

class Geral {

  static Widget buildLogo(BuildContext context, double percentWidth, double percentHeight) {
    return new Image.asset(
        "assets/images/logo_alternative.png",
        width: MediaQuery.of(context).size.width * percentWidth,
        height: MediaQuery.of(context).size.height * percentHeight
    );
  }

}