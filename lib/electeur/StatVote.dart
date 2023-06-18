import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:vote/electeur/ElecteurMain.dart';
import 'package:vote/electeur/Navbar.dart';
import 'package:vote/electeur/VoirStat.dart';


class StatVote extends StatefulWidget {
  const StatVote({super.key});

  @override
  State<StatVote> createState() => StatVoteMainState();
}

class StatVoteMainState extends State<StatVote>{

  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  Color ternary = const Color(0xFF8Fe3FF);
  /*--------------------------*/
  bool isLoading = false;
  /*--------------------------*/
  //ce tableau vas contenir la liste des id votes
  List _idVote = [];
  //ce tableau vas contenir la liste des votes
  List _listVote = [];

    @override
      void initState() {
        super.initState();
        fetchVotes();
  }

  @override
  Widget build(BuildContext context){
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
       builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:Scaffold(
            drawer: const NavBarElecteur(),
            appBar: AppBar(
               backgroundColor: const Color(0xFF0CB7F2),
               elevation: 0,
               title: Text(
                 'Voir Les Statistiques',
                style: GoogleFonts.poppins(
                  fontSize: 70.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
               ),
            ),
            body: Visibility(
              visible: isLoading,
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
                                color: _vote["statut"] == "plan"
                                    ? Colors.amber[300]
                                    : (_vote["statut"] == "pending"
                                        ? ternary
                                        : Colors.red[300]),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                                top: 10, bottom: 10)
                                            .r,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: 220.w,
                                        height: 60.w,
                                        child: MaterialButton(
                                            onPressed: () {
                                              print("les information du vote ${_vote}");
                                             navigateTopageStat(_vote);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Resultats",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 40.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        );
       }
    );
  }

  Future<void> fetchVotes() async{
    //cette fonction est appeler au chargement de la page 
    print("fetch votes stats");
    try{
   /*-------------------------------*/
      //on recupere l'id du candidat
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? electureur_id = prefs.getInt("user_id");
      /*-------------------------------*/
      //tempon id
      List _tmpId = [];
      /*-------------------------------*/
      final url = "https://vote-app.deviatraining.com/vote/api/user/${electureur_id}";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
         print(response.body);
         final json = jsonDecode(response.body) as List;
        if(json.length > 0){
          print(json[0]["vote_id"]);
          //ici je recupere les id des vote aux quelle le candidat a participer
          for (int i = 0; i < json.length; i++) {
            _tmpId.add(json[i]["vote_id"]);
          }
          setState(() {
          _idVote = _tmpId;
          //fetchVoteById();
          fectNewVoteById(json);
        });

        }else{
          // ignore: avoid_print
          print("we have an error ${response.statusCode}");
          showErrorMessage();
          setState(() {
            isLoading = true;
         });

        }
      } else {
        // ignore: avoid_print
        print("we have an error ${response.statusCode}");
        showErrorMessage();
        setState(() {
          isLoading = true;
        });

      }
    }catch(e){
      // ignore: avoid_print
      print("error ${e}");
      setState(() {
        isLoading = true;
      });
      showAlertWarning();
    }

  }

  Future<void> fectNewVoteById(List json)async{
    List _tmpListVote = [];
    // ignore: avoid_print
    print("dedans2 state");
    List _tmpListeVote = [];
    try {
      /*---------------------*/
      //on recupere l'id du candidat
       SharedPreferences prefs = await SharedPreferences.getInstance();
      int? electureur_id = prefs.getInt("user_id");
      /*--------------------*/
      //recupration des vote 
      final url =  "https://vote-app.deviatraining.com/vote/api/user/${electureur_id}";
      final uri = Uri.parse(url);
      /*----------------- */
      //recuperation 
      final response = await http.get(uri);
      //print(response.body);
      if(response.statusCode == 200){
        final json = jsonDecode(response.body) as List;
        for(int i = 0 ; i < json.length ; i++){
          if(json[i]["candidat_id"] !=null){
            _tmpListeVote.add(json[i]);
          }
        }
      }
       /*---------------------*/
      //fin  
      setState(() {
        isLoading = true;
        _listVote = _tmpListeVote;
      });
    }catch (e) {
      // ignore: avoid_print
      print("error fetching");
      setState(() {
        isLoading = true;
      });
    }
    
  }

/*------------------------------------------*/
//cette fonction sert a voir les statistique d'un vote 
Future<void> navigateTopageStat(Map _vote) async{
  //VoirStat
  final route =  MaterialPageRoute(builder: (context) => VoirStat(itemVote: _vote));
    Navigator.push(context, route);
}

  void showAlertWarning() {
    QuickAlert.show(
        context: context,
        title: "Attention",
        text: "impossible de joindre les serveurs",
        type: QuickAlertType.warning);
  }
  void showErrorMessage() {
    QuickAlert.show(
        context: context,
        title: "Attention",
        text: "une erreur est servenue veuillez réessayer plus tard",
        type: QuickAlertType.error);
  }
}