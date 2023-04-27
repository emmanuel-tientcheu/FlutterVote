import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/organisateur/Controllers/candidatController.dart';

import 'ajouterUnCandidat.dart';
import 'navBar.dart';
import 'package:intl/intl.dart';

class CreerVote extends StatefulWidget {
  const CreerVote({super.key});

  @override
  State<CreerVote> createState() => _CreerVoteState();
}

class _CreerVoteState extends State<CreerVote> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  String bonjour = "message";
  /*---------------------*/
  String _dateTimeString = " ";
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        _dateTimeString = _dateTime.toString();
      });
    });
  }

  /*---------------------------------------------*/
  //controller pour ajouter un candidat
  CandidatController candidatController = Get.find();

  /*---------------------------------------------*/
  //recuperation de la liste des candidats grace au setter
  List<Candidat> listCandidat = [];
  set candidat(List<Candidat> candidat) {
    listCandidat = candidat;
  }

  @override
  void initState() {
    super.initState();
    listCandidat = candidatController.listeCandidat;
    print("premier");
    print(candidatController.listeCandidat);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            drawer: const NavBar(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFF0CB7F2),
              title: Text(
                'Creer un vote',
                style: GoogleFonts.poppins(
                  fontSize: 70.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 120.h, horizontal: 60.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titre du vote',
                          style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.h, right: 50.w),
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF3F3F3F),
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: const TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        /*----------------------------------------------*/
                        space,
                        Text(
                          'Description du vote',
                          style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.h, right: 50.w),
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF3F3F3F),
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: const TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        /*----------------------------------------------*/
                        space,
                        Text(
                          'Date Début de du vote',
                          style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.h, right: 50.w),
                          //padding: EdgeInsets.symmetric(vertical: .h),
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF3F3F3F),
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: TextField(
                            controller: TextEditingController(
                                text:
                                    DateFormat('yyyy-MM-dd').format(_dateTime)),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _showDatePicker();
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*----------------------------------------------*/

                        space,
                        Text(
                          'Date limite du vote',
                          style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.h, right: 50.w),
                          //padding: EdgeInsets.symmetric(vertical: .h),
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF3F3F3F),
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: TextField(
                            controller: TextEditingController(
                                text:
                                    DateFormat('yyyy-MM-dd').format(_dateTime)),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _showDatePicker();
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*---------------------------------------------*/
                        // titre de la liste des candidats
                        space,
                        Text(
                          "Liste des candidats",
                          style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        space,
                        /*----------------------------------------------*/
                        //map des candidats
                        GetBuilder<CandidatController>(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            builder: (CandidatController) {
                          return Column(
                            children: CandidatController.listeCandidat
                                .asMap()
                                .entries
                                .map(
                                  (candidat) => Container(
                                    margin: const EdgeInsets.only(bottom: 30).r,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        /*--------------------------------*/
                                        //element cliquable pour retirer un cadidat de la liste
                                        GestureDetector(
                                          onTap: () {
                                            candidatController
                                                .retirerUnCandidat(
                                                    candidat.key);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "le candidat a ete retirer",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 50.sp,
                                                    color:
                                                        const Color(0xFF3F3F3F),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            //print(candidat.key);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                    right: 30, bottom: 15)
                                                .r,
                                            width: 90.w,
                                            height: 90.h,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  174, 158, 158, 158),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*---------------------------------------*/
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        //affichage des nom et fonction des candidats
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              candidat.value.nom,
                                              style: GoogleFonts.poppins(
                                                fontSize: 35.sp,
                                                color: const Color(0xFF3F3F3F),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.h,
                                            ),
                                            Text(
                                              candidat.value.fonction,
                                              style: GoogleFonts.poppins(
                                                fontSize: 35.sp,
                                                color: const Color(0xFF3F3F3F),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                        /*----------------------------------------------*/

                        space,
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AjoutCandidat(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 30).r,
                                width: 90.w,
                                height: 90.h,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "Ajouter des candidat",
                                style: GoogleFonts.poppins(
                                  fontSize: 50.sp,
                                  color: primary,
                                ),
                              )
                            ],
                          ),
                        )
                        /*----------------------------------------------*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget space = SizedBox(
  height: 55.h,
);
