import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/organisateur/Controllers/candidatController.dart';

import 'navBar.dart';

class OrganisateurMain extends StatefulWidget {
  const OrganisateurMain({super.key});

  @override
  State<OrganisateurMain> createState() => _OrganisateurMainState();
}

class _OrganisateurMainState extends State<OrganisateurMain> {
  CandidatController candidatController = Get.put(CandidatController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2160),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              drawer: const NavBar(),
              appBar: AppBar(
                backgroundColor: const Color(0xFF0CB7F2),
                title: Text(
                  'Organisation',
                  style: GoogleFonts.poppins(
                    fontSize: 70.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
  }
}


