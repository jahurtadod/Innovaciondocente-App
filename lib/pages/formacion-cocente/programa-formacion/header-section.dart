import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class HeaderSection extends StatelessWidget {
  // TODO: connect to firebase firestore
  const HeaderSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .4,
      padding: EdgeInsets.all(15),
      decoration: _buildDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Programa de Formación Docente',
            style: Theme.of(context).textTheme.overline.copyWith(color: Colors.white, fontSize: 25),
          ),
          SizedBox(height: 15),
          Text(
            'El Programa de Formación Docente de la universidad está orientado de forma prioritaria a facilitar y apoyar a nuestros docentes al desarrollo de sus necesidades de tipo formativo, dotándoles de las estrategias y recursos necesarios para desarrollar una serie de nuevas competencias profesionales. Por este motivo es preciso reflexionar sobre las nuevas exigencias profesionales y apoyar el desarrollo de dichas competencias desde la formación del profesorado y desde el enfoque de nuestra universidad.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      // image: DecorationImage(
      //   image: AssetImage(
      //     'assets/images/default.png',
      //   ),
      //   fit: BoxFit.cover,
      //   colorFilter: ColorFilter.mode(
      //     Colors.blue,
      //     BlendMode.colorBurn,
      //   ),
      // ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xff1a7dca),
          IndevColors.formacion,
        ],
      ),
    );
  }
}
