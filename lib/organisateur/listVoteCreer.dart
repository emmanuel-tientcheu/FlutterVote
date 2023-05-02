import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

import 'navBar.dart';
import 'package:http/http.dart' as http;

class ListVote extends StatefulWidget {
  const ListVote({super.key});

  @override
  State<ListVote> createState() => _ListVoteState();
}

class _ListVoteState extends State<ListVote> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  Color ternary = const Color(0xFF8Fe3FF);
  /*-----------------------------------------*/
  List _listVote = [];

  /*----------------------*/
  //au chargement de la page je recupère la liste de vote
  @override
  void initState() {
    super.initState();
    fetchVotes();
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
                  'Consulter les votes',
                  style: GoogleFonts.poppins(
                    fontSize: 70.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Visibility(
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: fetchVotes,
                    child: ListView.builder(
                        itemCount: _listVote.length,
                        itemBuilder: (context, index) {
                          //recupération de chacun des votes
                          final _vote = _listVote[index] as Map;
                          final id = _vote["id"];
                          //opperation de caste de date
                          DateTime dateFin = DateTime.parse(_vote["end_date"]);
                          String dateFinString =
                              DateFormat('yyyy-MM-dd').format(dateFin);

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Container(
                                  width: double.infinity,
                                  height: 300.h,
                                  padding: const EdgeInsets.only(
                                    top: 35,
                                    left: 35,
                                    right: 10,
                                    bottom: 10,
                                  ).r,
                                  decoration: BoxDecoration(
                                    color: ternary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _vote["title"],
                                          style: GoogleFonts.poppins(
                                            fontSize: 60.sp,
                                            color: secondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
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
                                              dateFinString,
                                              style: GoogleFonts.poppins(
                                                fontSize: 50.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  )),
            ),
          );
        });
  }

  Future<void> fetchVotes() async {
    try {
      const url = "http://10.0.2.2:8000/api/vote";
      final uri = Uri.parse(url);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['data'] as List;
        // ignore: avoid_print
        print("reussi");
        setState(() {
          _listVote = result;
          print(_listVote[0]);
        });
      } else {
        // ignore: avoid_print
        print("error");
      }
    } catch (e) {
      showAlertWarning();
      // ignore: avoid_print
      print("error $e");
    }
  }

  /*------------------------------------------------*/
  //cette fonction nous serviras a afficher une boite de dialoge
  void showAlertWarning() {
    QuickAlert.show(
        context: context,
        title: "Attention",
        text: "impossible de joindre les serveurs",
        type: QuickAlertType.warning);
  }
}