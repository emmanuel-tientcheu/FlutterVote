import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'creerUnVote.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavaBarState();
}

class _NavaBarState extends State<NavBar> {
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
          ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CreerVote(),
                  ),
                );
              },
              child: Text(
                "Créer un vote",
                style: GoogleFonts.poppins(
                  fontSize: 50.sp,
                  color: secondary,
                ),
              ),
            ),
            leading: Icon(
              Icons.edit_note,
              color: secondary,
              size: 35,
            ),
          ),
          spacer,
          ListTile(
            title: Text(
              "Selectionner les électeurs",
              style: GoogleFonts.poppins(
                fontSize: 50.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.done,
              color: secondary,
              size: 25,
            ),
          ),
          spacer,
          ListTile(
            title: Text(
              "Consulter la liste des votes",
              style: GoogleFonts.poppins(
                fontSize: 50.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.format_list_numbered,
              color: secondary,
              size: 25,
            ),
          ),
          spacer,
          ListTile(
            title: Text(
              "Voir les votes",
              style: GoogleFonts.poppins(
                fontSize: 50.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.list_alt,
              color: secondary,
              size: 25,
            ),
          ),
          spacer,
          ListTile(
            title: Text(
              "Statistics",
              style: GoogleFonts.poppins(
                fontSize: 50.sp,
                color: secondary,
              ),
            ),
            leading: Icon(
              Icons.query_stats,
              color: secondary,
              size: 25,
            ),
          ),
          spacer,
          ListTile(
            title: Text(
              " ",
              style: GoogleFonts.poppins(
                fontSize: 50.sp,
                color: secondary,
              ),
            ),
          ),
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
