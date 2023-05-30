import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vote/electeur/ElecteurMain.dart';
import 'package:vote/electeur_path/allPageForInscriptionElecteur.dart';
import 'package:vote/electeur_path/motDePasseOublie.dart';
import 'package:vote/organisateur/organisateurMain.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConnexionElecteur extends StatefulWidget {
  final String role;
  const ConnexionElecteur({Key? key, required this.role}) : super(key: key);
  @override
  State<ConnexionElecteur> createState() => _ConnexionElecteurState();
}

class _ConnexionElecteurState extends State<ConnexionElecteur> {
  String roleRecive = "";
  @override
  void initState() {
    super.initState();
    roleRecive = widget.role;
    print(roleRecive);
  }

  /*-------------------------------*/
  //variable de recuperation du text dans le input
  TextEditingController _mdpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  /*-------------------------------*/
  //cette variable serviras a voir si la requette a deja ete traité
  bool _isload = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2160),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: const Color(0xFF0CB7F2),
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              body: Column(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: headerSection,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: const Color(0xFF3F3F3F),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0CB7F2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setWidth(50)),
                          TextField(
                            controller: _mdpController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              labelText: 'Mot De Passe',
                              labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: const Color(0xFF3F3F3F),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('ngvc'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0CB7F2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setWidth(25)),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MotDePasseElecteurOublie(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Mot de passe oublié ?',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color(0xFF3F3F3F),
                                    ),
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(100)),
                                MaterialButton(
                                  padding: const EdgeInsets.all(10),
                                  onPressed: () {
                                    roleRecive == "electeur"
                                        ? /* Navigator.push(context, MaterialPageRoute(builder: (context) => const ElecteurMain()))*/ loginE()
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const OrganisateurMain()));
                                  },
                                  color: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(40),
                                      right: Radius.circular(40),
                                    ),
                                    side: BorderSide(
                                        color: Color(0xFF53d4ff), width: 2),
                                  ),
                                  child: Center(
                                    child: !_isload
                                        ? Text(
                                            'Se connecter',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: const Color(0xFF53d4ff),
                                            ),
                                          )
                                        : const CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(370),
                            // decoration: const BoxDecoration(color: Colors.red),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "j'ai pas de compte",
                                    style: GoogleFonts.poppins(
                                      fontSize: 50.sp,
                                      color: const Color(0xFF3F3F3F),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllPageInscriptionElecteur(
                                                  role: roleRecive),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "créer un compte",
                                      style: GoogleFonts.poppins(
                                        fontSize: 50.sp,
                                        color: const Color(0xFF0CB7F2),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> loginE() async {
    try {
      setState(() {
        _isload = true;
      });
      const url = "http://10.0.2.2:8000/api/login";
      final uri = Uri.parse(url);

      /*---------------------------*/
      //code de la navigation vers la page des electeur
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ElecteurMain()));
      final body = {
        "email": _emailController.text,
        "password": _mdpController.text,
      };

      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _isload = false;
        });
        final json = jsonDecode(response.body) as Map;
        // ignore: avoid_print
        // print(json["role"]);
        storeUserLog(json);
      } else {
        setState(() {
          _isload = false;
        });
        showErrorMessage("les identifiant de connexion sont incoreectes");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //cette fonction sert a save un user apres le login
  void storeUserLog(Map infoUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //print("reccuperation ${prefs.getString('username')}");
      prefs.setString("role", infoUser["role"]);
      prefs.setString("username", infoUser["username"]);
      prefs.setString("user_id", infoUser["user_id"]);
      print("yes");
    } catch (e) {
      // ignore: avoid_print, unnecessary_brace_in_string_interps
      print("error ${e}");
    }
  }

  //cette fonction sert a rediriger le user s'il est deja loger
  void getUserLog() async {}

  void showErrorMessage(String message) {
    QuickAlert.show(
        context: context,
        title: "Echec de l'opperation",
        text: message,
        type: QuickAlertType.error);
  }
}

Widget headerSection = Container(
  width: double.infinity,
  height: ScreenUtil().setHeight(540),
  decoration: const BoxDecoration(
    color: Color(0xFF0CB7F2),
  ),
  child: Padding(
    padding: const EdgeInsets.only(left: 15, top: 13),
    child: Text(
      'Se Connecter',
      style: GoogleFonts.poppins(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.4116667);
    path0.quadraticBezierTo(size.width * 0.0884167, size.height * 0.6398333,
        size.width * 0.2304750, size.height * 0.5422500);
    path0.cubicTo(
        size.width * 0.3995750,
        size.height * 0.4144667,
        size.width * 0.4767417,
        size.height * 0.3960833,
        size.width * 0.5765917,
        size.height * 0.4434167);
    path0.cubicTo(
        size.width * 0.6821000,
        size.height * 0.4932833,
        size.width * 0.8322333,
        size.height * 0.8695667,
        size.width * 0.9159500,
        size.height * 0.8271333);
    path0.quadraticBezierTo(size.width * 0.9960667, size.height * 0.7830500,
        size.width, size.height * 0.6455500);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.4116667);
    path0.quadraticBezierTo(size.width * 0.0884167, size.height * 0.6398333,
        size.width * 0.2304750, size.height * 0.5422500);
    path0.cubicTo(
        size.width * 0.3995750,
        size.height * 0.4144667,
        size.width * 0.4767417,
        size.height * 0.3960833,
        size.width * 0.5765917,
        size.height * 0.4434167);
    path0.cubicTo(
        size.width * 0.6821000,
        size.height * 0.4932833,
        size.width * 0.8322333,
        size.height * 0.8695667,
        size.width * 0.9159500,
        size.height * 0.8271333);
    path0.quadraticBezierTo(size.width * 0.9960667, size.height * 0.7830500,
        size.width, size.height * 0.6455500);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
