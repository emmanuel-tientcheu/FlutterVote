import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/organisateur/Controllers/candidatController.dart';
import 'package:vote/organisateur/Controllers/voteController.dart';
import 'package:vote/organisateur/ajouterCandidat.dart';

import 'ajouterUnCandidat.dart';
import 'navBar.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import 'package:shared_preferences/shared_preferences.dart';


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
  DateTime _dateTimeEnd = DateTime.now();
  /*---------------------*/
  TimeOfDay _heureDebut = TimeOfDay.now();
  TimeOfDay _heureFin = TimeOfDay.now();
  /*---------------------------------*/
  //variable pour le loader
  bool _isloading = false;
  /*---------------------------------*/
  //cette variable vas contenir l'id du vote creer
  dynamic _idVote = 0;

  void _showDatePickerEnd() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _dateTimeEnd = value!;
        _dateTimeString = _dateTimeEnd.toString();
      });
    });
  }

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
  //cette fonction aide a choisir une heure
  void _showTimePickerStart() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _heureDebut = value!;
        //nous convertisson l'heure sous le format heure minute
        print(
            "${_heureDebut.hour}:${_heureDebut.minute.toString().padLeft(2, '0')}");
      });
    });
  }

  /*---------------------------------------------*/
  //cette fonction aide a choisir une fin
  void _showTimePickerEnd() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _heureFin = value!;
        //nous convertisson l'heure sous le format heure minute
        print(
            "${_heureFin.hour}:${_heureFin.minute.toString().padLeft(2, '0')}");
      });
    });
  }

  /*---------------------------------------------*/
  //controller pour la creation de vote
  VoteController voteController = Get.put(VoteController());
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
                        /*--------------------------*/
                        //builder titre vote
                        GetBuilder<VoteController>(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            builder: (VoteController) {
                          return Container(
                            width: double.infinity,
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
                            child: TextField(
                              controller: TextEditingController(
                                  text: VoteController.titre),
                              onChanged: (value) =>
                                  VoteController.changeTitreController(value),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 15, left: 15, top: 30),
                                border: InputBorder.none,
                              ),
                            ),
                          );
                        }),

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
                        /*--------------------------*/
                        //builder description vote
                        GetBuilder<VoteController>(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            builder: (VoteController) {
                          return Container(
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
                            child: TextField(
                              controller: TextEditingController(
                                  text: VoteController.description),
                              onChanged: (value) =>
                                  VoteController.changeDescriptionController(
                                      value),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 15, left: 15, top: 30),
                                border: InputBorder.none,
                              ),
                            ),
                          );
                        }),
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
                        /*--------------------------*/
                        //builder date debut vote
                        GetBuilder<VoteController>(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            builder: (VoteController) {
                          return Container(
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
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(_dateTime)),
                              onChanged: (value) {
                                VoteController.changeStartDateController(
                                    DateFormat('yyyy-MM-dd').format(_dateTime));
                              },
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
                          );
                        }),

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
                        /*--------------------------*/
                        //builder date limite vote
                        GetBuilder<VoteController>(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            builder: (VoteController) {
                          return Container(
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
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(_dateTimeEnd)),
                              onChanged: (value) =>
                                  VoteController.changeEndDateController(
                                      DateFormat('yyyy-MM-dd')
                                          .format(_dateTime)),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 15, left: 15, top: 30),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _showDatePickerEnd();
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        /*---------------------------------------------*/
                        space,
                        Text(
                          'Heure de debut du Vote',
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
                            /*controller: TextEditingController(
                                  text: DateFormat('yyyy-MM-dd').format(_dateTimeEnd)),*/
                            controller: TextEditingController(
                                text: _heureDebut.format(context)),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _showTimePickerStart();
                                },
                                icon: const Icon(
                                  Icons.alarm,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*---------------------------------------------*/
                        //heure de fin
                        space,
                        Text(
                          'Heure de Fin du Vote',
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
                            /*controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_dateTimeEnd)),*/
                            controller: TextEditingController(
                                text: _heureFin.format(context)),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 15, left: 15, top: 30),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _showTimePickerEnd();
                                },
                                icon: const Icon(
                                  Icons.alarm,
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
                            builder: (CandidatController) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: CandidatController.candidat.length,
                            itemBuilder: ((context, index) {
                              final candidat =
                                  CandidatController.candidat[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 30).r,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    /*---------------------------------------*/
                                    //bouton pour retirer
                                    Container(
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
                                      child: InkResponse(
                                        radius: 20,
                                        onTap: () {
                                          CandidatController
                                              .addAndRemoveNewCandidat(
                                                  candidat);
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
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
                                          candidat['complete_name'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 40.sp,
                                            color: const Color(0xFF3F3F3F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          candidat['complete_name'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 40.sp,
                                            color: const Color(0xFF3F3F3F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                          );
                        }),
                        /*----------------------------------------------*/

                        space,
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AjouterCandidatVote(),
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
                        ),
                      ],
                    ),
                  ),

                  /*----------------------------------------------*/
                  //de soumission
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 550.w,
                        height: 120.h,
                        margin: const EdgeInsets.only(bottom: 30).r,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            creationVote();
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40),
                              right: Radius.circular(40),
                            ),
                          ),
                          child: Center(
                            child: _isloading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white))
                                : Text(
                                    'Création',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*----------------------------------------------*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //fonction de creation d'un vote
  Future<void> creationVote() async {
    // ignore: avoid_print
    print("creation du vote");
    //form data qui seras envoyer pour la creation de la requette

    try {
      /*-------------------------*/
      //recuperer l'id du createur 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("reccuperation ${prefs.getString('username')}");
      int? user_id = prefs.getInt("user_id");
      /*------------------------*/
      print("test");
      setState(() {
        _isloading = true;
      });
      const url = "https://vote-app.deviatraining.com/vote/api/vote";
      final uri = Uri.parse(url);
      final formData = http.MultipartRequest('POST', uri);
      formData.fields.addAll({
        "title": voteController.titre,
        "description": voteController.description,
        "start_date": DateFormat('yyyy-MM-dd').format(_dateTime),
        "end_date": DateFormat('yyyy-MM-dd').format(_dateTimeEnd),
        "start_hour":
            "${_heureDebut.hour.toString().padLeft(2, '0')}:${_heureDebut.minute.toString().padLeft(2, '0')}",
        "statut": "plan",
        "user_id": user_id.toString(),
        "end_hour":
            "${_heureFin.hour.toString().padLeft(2, '0')}:${_heureFin.minute.toString().padLeft(2, '0')}",
      });

      for (var entry in formData.fields.entries) {
        print('${entry.key}: ${entry.value}');
      }

      if (candidatController.candidat.length > 0) {
        final response = await formData.send();
        if (response.statusCode == 201) {
          /*------------------------------------------*/
          //recuperation de l'id de la creation
          final streamResponse =
              await response.stream.transform(utf8.decoder).toList();
          final String responseString = streamResponse.join();
          print(responseString);
          setState(() {
            _idVote = responseString;
            print(_idVote);
          });
          //appel de la fonction d'ajout des candidats
          addCandidat();
          /*------------------------------------------*/
          // ignore: avoid_print
          print("Success");
          setState(() {
            _isloading = false;
          });

          showAlertSucess("Votre vote a bien été créer");
        } else {
          // ignore: avoid_print
          setState(() {
            _isloading = false;
          });
          final responseStream = await response.stream;
          final responseData = await http.ByteStream(responseStream).toBytes();
          final responseString = utf8.decode(responseData);
          print(responseString);
          print("Upload failed with status ${response.statusCode}");
          showErrorMessage(
              "impossible de d'aboutir la requette \n veuiller verifier si tout les champs sont correcte");
        }
      }else{
        setState(() {
          _isloading = false;
        });
        showErrorMessage("des candidats doivent etre assigné a un vote");
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      showAlertWarning();
      // ignore: avoid_print, unnecessary_brace_in_string_interps
      print("error : $e");
    }
  }

  Future<void> addCandidat() async {
    //recuperation des id des candidats selectionner
    List listCandidatId = [];
    for (int i = 0; i < candidatController.candidat.length; i++) {
      listCandidatId.add(candidatController.candidat[i]['id']);
    }
    const url = "https://vote-app.deviatraining.com/vote/api/vote_candidat";
    final uri = Uri.parse(url);
    final body = {"vote_id": _idVote, "candidat_ids": listCandidatId};

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(listCandidatId);
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

  void showErrorMessage(String message) {
    QuickAlert.show(
        context: context,
        title: "Echec de l'opperation",
        text: message,
        type: QuickAlertType.error);
  }

  void showAlertSucess(String message) {
    QuickAlert.show(
        context: context,
        title: "Oppération reussie",
        text: message,
        type: QuickAlertType.success);
  }
}

Widget space = SizedBox(
  height: 55.h,
);
