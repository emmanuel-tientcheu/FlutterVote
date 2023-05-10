import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class VotePage extends StatefulWidget {
  final Map? itemVote;
  const VotePage({Key? key, required this.itemVote}) : super(key: key);

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  Color ternary = const Color(0xFF8Fe3FF);
  /*-----------------------------------------*/
  //au chargement de la page je recupère la liste de vote
  dynamic details;
  void initState() {
    super.initState();
    details = widget.itemVote;
    fetchVote();
  }

  /*-----------------------------------------*/
  //cette varaible contiendras le details du vote selectionné
  dynamic actuDetails;
  //cette varaible contiendrad les candidats du vote
  List candidats = [];

  bool isLoading = false;

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
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: primary,
              title: Center(
                child: Text(
                  'Voter\t\t      ',
                  style: GoogleFonts.poppins(
                    fontSize: 70.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Visibility(
              visible: isLoading,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: fetchVote,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      //ce variable seront utiliser pour la date
                      DateTime date = DateTime.parse(actuDetails["created_at"]);
                      String dateString = DateFormat('yyyy-MM-dd').format(date);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  width: double.infinity,
                                  height: 270.h,
                                  decoration: BoxDecoration(
                                    color: ternary,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          actuDetails["title"],
                                          style: GoogleFonts.poppins(
                                            fontSize: 60.sp,
                                            color: secondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Date limite : ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 50.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              dateString,
                                              style: GoogleFonts.poppins(
                                                fontSize: 50.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                /*---------------------------------------------*/
                                //liste des candidats
                                SizedBox(
                                  height: 50.h,
                                ),
                                Text(
                                  "Liste des candidats",
                                  style: GoogleFonts.poppins(
                                    fontSize: 50.sp,
                                    color: secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                //liste des candidats
                                Container(
                                  width: double.infinity,
                                  height: 550.h,
                                  // color: Colors.red,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: candidats.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final candidat = candidats[index];
                                            return Row(
                                              children: [
                                                /*---------------------------------------*/
                                                //affichage de pa photo de profile
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                          bottom: 20, top: 10)
                                                      .r,
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

                                                /*-----------------------------------------*/
                                                //information des candidats
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                                left: 80)
                                                            .r,
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          candidat[
                                                              "complete_name"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 50.sp,
                                                            color: secondary,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          candidat[
                                                              "complete_name"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 50.sp,
                                                            color: secondary,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                //fin candidat informations
                                                /*-------------------------------------------------*/
                                                //input a coucher a cocher pour choisir un candidat
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
                                                       
                                                     },
                                                  )
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //fin liste de candidats
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchVote() async {
    try {
      final url = "http://10.0.2.2:8000/api/vote/${details["id"]}";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['data'] as dynamic;

        setState(() {
          actuDetails = result;
          isLoading = true;
          candidats = actuDetails["candidats"] as List;
        });
      }
    } catch (e) {
      showAlertWarning();
    }
  }

  void showAlertWarning() {
    QuickAlert.show(
        context: context,
        title: "Attention",
        text: "impossible de joindre les serveurs",
        type: QuickAlertType.warning);
  }
}
