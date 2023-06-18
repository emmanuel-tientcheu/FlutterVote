import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quickalert/quickalert.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';


class VoirStat extends StatefulWidget {
  final Map? itemVote;
  const VoirStat({Key? key, required this.itemVote}) : super(key : key);

  @override 
  State<VoirStat> createState() => _VoirStatePage();
}

class _VoirStatePage extends  State<VoirStat>{
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  Color ternary = const Color(0xFF8Fe3FF);
  /*-----------------------------------------*/
  //au chargement de la page je recupère la liste de vote
  dynamic details;
  void initState(){
    details = widget.itemVote;
    fetchVote();
  }
  /*------------------------------------*/
  bool isLoading = false;
  /*-----------------------------------------*/
  //cette varaible contiendras le details du vote selectionné
  dynamic actuDetails;
  /*------------------------------*/
  //cette varaible contiendrad les candidats du vote
  List candidats = [];

  @override 
  Widget build(BuildContext context){
    return ScreenUtilInit(
   designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
          return GetMaterialApp(
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
                  'Statistiques\t\t      ',
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
                      DateTime date = DateTime.parse(actuDetails["created_at"]);
                      String dateString = DateFormat('yyyy-MM-dd').format(date);
                      return Column(
                       children: [
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //recuperation des information de bases 
                                /*---------------------------------------*/
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
                                 //fin recuperation des information de bases 
                                /*---------------------------------------*/
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
                                Container(
                                  width: double.infinity,
                                  height: 550.h,
                                   child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                         ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                           itemCount: candidats.length,
                                             itemBuilder: (BuildContext context, int index){
                                              final candidat = candidats[index];
                                                return Row(
                                                  children: [
                                                  /*---------------------------------------*/
                                                  //affichage de pa photo de profile
                                          
                                                    Container(
                                                    margin: const EdgeInsets.only( bottom: 20, top: 10).r,
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
                                                      /*-----------------------------------------------------*/
                                                      //fin de section photo
                                                      SizedBox(
                                                        width: 30.w,
                                                      ),
                                                    /*----------------------------------------*/
                                                    //information du candidat
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 610.w,
                                                          height: 150.h,
                                                          //color: Colors.red,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width: 50.w,),
                                                              Flexible(
                                                                child: 
                                                                Padding(padding: EdgeInsets.only(left: 10)
                                                                ,child:        Text(
                                                                  candidat["complete_name"],
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize: 50.sp,
                                                                     color: secondary,
                                                                  ),
                                                                ),),
                                                         
                                                              ),
                                                              SizedBox(height: 40.h,),
                                                              Flexible(
                                                               child: LinearPercentIndicator(
                                                                lineHeight: 10,
                                                                percent: candidat["pourcentage_vue"]??0,
                                                                progressColor: primary,
                                                                animation: true,
                                                                animationDuration: 2000,
                                                               
                                                               ),
                                                                ),
                                                              /*----------------------------------------*/
                                                              //fin information du candidat
                                                              
                                                                
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  /*----------------------------------------*/
                                                              //affichage des pourcentages
                                                    Column(
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(top:1),
                                                        child: Text(candidat['total'] ?? "0 Vote" ,                                                       style: GoogleFonts.poppins(
                                                          fontSize: 50.sp,
                                                          color: primary,
                                                          fontWeight: FontWeight.w500
                                                          ),
                                                           ),
                                                           ),

                                                           Padding(padding: EdgeInsets.only(top:1),
                                                        child: Text(candidat['pourcentage'] ?? "0 %" ,                                                       style: GoogleFonts.poppins(
                                                          fontSize: 30.sp,
                                                          color: primary,
                                                          fontWeight: FontWeight.w500
                                                          ),
                                                           ),
                                                           ),
                                                        
                                                      ],
                                                    )
                                                  ],
                                                );
                                             }
                                         ),
                                      ],
                                    ),
                                   ),
                                )
                              ],
                          ),
                        )
                       ],
                      );
                    }
                ),

              ),
            ),
            ),
          );
      }
    );

  }
    Future<void> fetchVote() async {
      print("details statics");
      /*---------------------------*/
      dynamic tmp_info_vote;
      dynamic tmp_total = 0;
      dynamic tmp_candidat ;
      /*---------------------------*/
      try {
      print("le details ${details}");
      print("le vote ${details["vote_id"]}");
      final url =
          "https://vote-app.deviatraining.com/vote/api/vote/${details["vote_id"]}";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['vote'] as Map;
        print("le vote en question ${json["vote"] as Map}");
        print("resultat ${json["electeursParCandidat"] as List}");
        /*-------------------------------------------*/
        //calcul des stats 
        tmp_info_vote = json["electeursParCandidat"] as List;
        for(var i = 0; i< tmp_info_vote.length; i++){
          tmp_total += tmp_info_vote[i]['total']!;
        }

         for(var i = 0; i< tmp_info_vote.length; i++){
          tmp_info_vote[i]['pourcentage'] = tmp_info_vote[i]['total']*100/tmp_total;
          tmp_info_vote[i]['pourcentage_vue'] =  tmp_info_vote[i]['pourcentage'] / 100;
        //  print( tmp_info_vote[i]['total']*100/tmp_total);
        //  print( tmp_info_vote[i]['pourcentage']);
         }
         //ici on charge les information qui seront affiché a la vue
        
        tmp_candidat = json['candidats'] as List;
        print(tmp_candidat.length);
         for(var i = 0 ; i < tmp_info_vote.length ; i++){
            for(var j = 0 ; j<tmp_candidat.length ; j++){
              if(tmp_candidat[j]['id'] == tmp_info_vote[i]['candidat_id']){
                  tmp_candidat[j]['pourcentage'] =  "${tmp_info_vote[i]['pourcentage'].toStringAsFixed(2)}%";
                  tmp_candidat[j]['pourcentage_vue'] = tmp_info_vote[i]['pourcentage_vue'];
                   tmp_candidat[j]['total'] = "${tmp_info_vote[i]['total']} Votes";
              }
            }
         }

         print(tmp_candidat[0]["pourcentage"]);
        

        
        setState(() {
          if (actuDetails == null) {
            actuDetails = result;
            isLoading = true;
            candidats = tmp_candidat ;
          }
        });
      }
      } catch (e) {
        print(e);
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

  void showAlertSucess(String message) {
    QuickAlert.show(
        context: context,
        title: "Oppération reussie",
        text: message,
        type: QuickAlertType.success);
  }

  void showErrorMessage(String message) {
    QuickAlert.show(
        context: context,
        title: "Echec de l'opperation",
        text: message,
        type: QuickAlertType.error);
  }



}