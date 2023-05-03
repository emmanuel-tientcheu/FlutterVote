import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:vote/organisateur/Controllers/candidatController.dart';

import 'package:get/get.dart';

class AjouterCandidatVote extends StatefulWidget {
  const AjouterCandidatVote({super.key});

  @override
  State<AjouterCandidatVote> createState() => _AjouterCandidatVoteState();
}

class _AjouterCandidatVoteState extends State<AjouterCandidatVote> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  /*--------------------------------------------*/
  //input de la recherche
  final searchController = TextEditingController();
  /*--------------------------------------------*/
  final List _names = [
    {"name": "emma charles charles charles charles", "_isChecked": false},
    {"name": "charles", "_isChecked": false},
    {"name": "yvan", "_isChecked": false},
    {"name": "toto", "_isChecked": false},
    {"name": "cedric", "_isChecked": false},
    {"name": "franck", "_isChecked": false},
    {"name": "henry", "_isChecked": false},
    {"name": "jean", "_isChecked": false},
    {"name": "jack", "_isChecked": false},
    {"name": "romaric", "_isChecked": false},
  ];
  List _filtered = [];
  /*--------------------------------------------*/
  //controller qui contient la liste
  CandidatController candidatController = Get.find();
  List candidats = [];

  /*--------------------------------*/
  //fonction de recherche
  void filterNames(String query) {
    setState(() {
      _filtered = _names
          .where((name) =>
              name['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCandidat();
    _filtered = _names;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              title: Text(
                'Ajouter des candidats',
                style: GoogleFonts.poppins(
                  fontSize: 70.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: primary,
            ),
            body: Column(
              children: [
                /*-------------------------------------*/
                //search bar
                Container(
                  width: double.infinity,
                  height: 120.h,
                  margin: const EdgeInsets.all(30).w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: primary,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      candidatController.filteredCandidat(value);
                    },
                    controller: searchController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 10).r,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondary,
                      ),
                      hintText: "Recherche",
                      hintStyle: GoogleFonts.poppins(
                        color: secondary,
                      ),
                    ),
                  ),
                ),
                //end search bar
                /*-------------------------------------*/

                /*-------------------------------------*/
                //liste des candidats present dans le systeme
                Container(
                  margin: const EdgeInsets.all(30).w,
                  width: double.infinity,
                  height: 1500.h,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        //builder
                        GetBuilder<CandidatController>(
                            builder: (CandidatController) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                CandidatController.filteredListcandidat.length,
                            itemBuilder: (context, index) {
                              final candidat =
                                  CandidatController.filteredListcandidat[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      /*---------------------------------------*/
                                      //affichage de pa photo de profile
                                      Container(
                                        width: 150.w,
                                        height: 150.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primary,
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                color: Color.fromARGB(
                                                    55, 0, 0, 0)),
                                          ],
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/profile.jpg'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      //fin de l'affichage 
                                      /*---------------------------------------*/
                                      //information du candidat 
                                          Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 80).r,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                candidat["complete_name"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 50.sp,
                                                  color: secondary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                candidat["complete_name"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 50.sp,
                                                  color: secondary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //fin de la partie d'affichage des information 
                                      /*--------------------------------------------------*/
                                      //input checkbox
                                         Container(
                                        width: 90.w,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          color: primary,
                                        ),
                                        child: InkResponse(
                                          radius: 20,
                                          onTap: () {
                                            CandidatController.addAndRemoveNewCandidat(candidat);
                                          },
                                          child: candidat["isChecked"]
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                        ),
                                      ),

                                    ],
                                  ),
                                  //fin checkbox
                                   SizedBox(
                                    height: 50.h,
                                  )
                                ],
                              );
                            },
                          );
                        },
                        ),
                       
                      ],
                    ),
                  ),
                ),
                //end list candidats
                /*-------------------------------------*/
              ],
            ),
          ),
        );
      },
    );
  }

  //cette methode est utiliser pour recuperer les candidats au chargement de la page
  Future<void> fetchCandidat() async {
    try {
      const url = "http://10.0.2.2:8000/api/filter_user?role=candidat";
      final uri = Uri.parse(url);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final resultat = jsonDecode(response.body) as List;
        for (dynamic result in resultat) {
          result["isChecked"] = false;
          candidats.add(result);
          candidatController.chargerCandidat(result,resultat.length);
        }
        print(candidats);
      } else {
        print("error");
      }
    } catch (e) {
      // ignore: avoid_print
      print("error $e");
    }
  }
}
