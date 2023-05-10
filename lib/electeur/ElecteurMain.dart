import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vote/electeur/Navbar.dart';

class ElecteurMain extends StatefulWidget {
  const ElecteurMain({super.key});

  @override
  State<ElecteurMain> createState() => ElecteurMainState();
}

class ElecteurMainState extends State<ElecteurMain> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
             drawer: const NavBarElecteur(),
              appBar: AppBar(
                 backgroundColor: const Color(0xFF0CB7F2),
                 title: Text(
                  'Electeur',
                  style: GoogleFonts.poppins(
                    fontSize: 70.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
          ),
        );
      },
    );
  }
}