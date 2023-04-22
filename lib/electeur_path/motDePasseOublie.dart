import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MotDePasseElecteurOublie extends StatefulWidget {
  const MotDePasseElecteurOublie({super.key});
  @override
  State<MotDePasseElecteurOublie> createState() =>
      _MotDePasseElecteurOublieState();
}

class _MotDePasseElecteurOublieState extends State<MotDePasseElecteurOublie> {
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
                  mainSection,
                ],
              ),
            ),
          );
        });
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
      'Mot de passe oublié',
      style: GoogleFonts.poppins(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

Widget mainSection = Padding(
  padding: const EdgeInsets.only(left: 15, right: 15),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          'Entrez votre adresse email',
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xFF3F3F3F),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(50)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffeeeeee),
            width: 2.0,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(40),
            right: Radius.circular(40),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffeeeeee),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: const TextField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 15, left: 15, top: 15),
            border: InputBorder.none,
          ),
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(100)),
      Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              height: ScreenUtil().setHeight(5),
              decoration: const BoxDecoration(
                color: Color(0xffeeeeee),
              ),
            ),
          ),
          Text(
            "Or",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: const Color(0xFF0CB7F2),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              height: ScreenUtil().setHeight(5),
              decoration: const BoxDecoration(
                color: Color(0xffeeeeee),
              ),
            ),
          )
        ],
      ),
      SizedBox(height: ScreenUtil().setHeight(90)),
      Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          'Entrez votre numéro',
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xFF3F3F3F),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(50)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffeeeeee),
            width: 2.0,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(40),
            right: Radius.circular(40),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffeeeeee),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: const TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 15, left: 15, top: 15),
            border: InputBorder.none,
          ),
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(200)),
      MaterialButton(
        padding: const EdgeInsets.all(10),
        onPressed: () {},
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40),
            right: Radius.circular(40),
          ),
          side: BorderSide(color: Color(0xFF53d4ff), width: 2),
        ),
        child: Center(
          child: Text(
            'Envoyez',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: const Color(0xFF53d4ff),
            ),
          ),
        ),
      ),
    ],
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
