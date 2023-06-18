import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur/ElecteurMain.dart';
import 'package:vote/electeur/StatVote.dart';
import 'package:vote/electeur/allVote.dart';

class NavBarElecteur extends StatefulWidget {
  const NavBarElecteur({super.key});

  @override
  State<NavBarElecteur> createState() => _NavaBarState();
}

class _NavaBarState extends State<NavBarElecteur> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "Paramètre",
              style: GoogleFonts.poppins(
                fontSize: 60.sp,
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          spacer,
          GestureDetector(
            onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const VotesCreer(),
                  ),
                );
            },
            child: ListTile(
              title: Text(
                "Consulter la liste des vote",
                style: GoogleFonts.poppins(
                  fontSize: 45.sp,
                  color: secondary,
                ),
              ),
              leading: Icon(
                Icons.done,
                color: secondary,
                size: 25,
              ),
            ),
          ),
          spacer,
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ElecteurMain(),
                  ),
                );
            },
            child: ListTile(
            title: Text(
              "Mes Participations",
              style: GoogleFonts.poppins(
                fontSize: 45.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.done,
              color: secondary,
              size: 25,
            ),
          ),
          ),
          
          spacer,
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const StatVote()));
            },
            child: ListTile(
              title: Text(
              "Statistiques",
              style: GoogleFonts.poppins(
                fontSize: 45.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.done,
              color: secondary,
              size: 25,
            ),
            ),
          ),
          spacer,
        ],
      ),
    );
  }
}

Widget spacer = Container(
  margin: const EdgeInsets.only(top: 10, bottom: 10).r,
  width: double.infinity,
  height: 1.h,
  decoration: const BoxDecoration(
    color: Color(0xFF3F3F3F),
  ),
);
