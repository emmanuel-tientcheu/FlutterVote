import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote/organisateur/Controllers/candidatController.dart';

import 'package:get/get.dart';

class AjoutCandidat extends StatefulWidget {
  const AjoutCandidat({Key? key}) : super(key: key);

  @override
  State<AjoutCandidat> createState() => _AjoutCandidatState();
}

class _AjoutCandidatState extends State<AjoutCandidat> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  /*---------------------------------------------*/
  //controller pour ajouter un candidat
  CandidatController candidatController = Get.find();
  /*---------------------------------------------*/
  //ensemble des varaibles et methode pour choisir une image

  File? _image; //image choisis
  PickedFile? _pickedFile; //contiendras les information de l'image
  final _picker = ImagePicker(); // methode pour choisir l'image

  Future<void> _pickImage() async {
    try {
      _pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        setState(() {
          _image = File(_pickedFile!.path);
        });
      }
    } catch (e) {
      // ignore: avoid_print, unnecessary_brace_in_string_interps
      print("error selected image: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
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
                /*-------------------------------*/
                //profile section
                Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 80).r,
                        width: 430.w,
                        height: 430.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 3,
                                color: Color.fromARGB(55, 0, 0, 0)),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          //affichage de l'image dans le cas l'utilisateur a selectionné une image
                          child: _pickedFile != null
                              ? Image.file(
                                  File(_pickedFile!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/profile.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0.3.sw,
                      child: Container(
                        height: 150.w,
                        width: 150.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: primary,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: const Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                /*-------------------------------*/
                //tout les inputs de cette page
                /*-------------------------------*/
                Column(
                  children: [
                    /*-------------------------------*/
                    //nom du candidat
                    space,
                    GetBuilder<CandidatController>(
                        builder: (CandidatController) {
                      return Container(
                        margin: const EdgeInsets.only(
                                left: 60, right: 60, top: 70, bottom: 5)
                            .r,
                        //padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 5),
                        height: 150.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
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
                              text: CandidatController.nom.value),
                          onChanged: (value) =>
                              CandidatController.changeNomController(value),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 30).r,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: secondary,
                            ),
                            hintText:
                                'Veillez entrez le nom complet du candidat',
                            hintStyle: GoogleFonts.poppins(
                              color: secondary,
                            ),
                          ),
                        ),
                      );
                    }),

                    /*-------------------------------------------*/
                    //age du candidat
                    GetBuilder<CandidatController>(
                        builder: (CandidatController) {
                      return Container(
                        margin: const EdgeInsets.only(
                                left: 60, right: 60, top: 60, bottom: 5)
                            .r,
                        //padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 5),
                        height: 150.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
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
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: candidatController.age.value),
                          onChanged: (value) =>
                              candidatController.changeAgeController(value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 30).r,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: secondary,
                            ),
                            hintText: 'Veillez entrez l\'age du candidat',
                            hintStyle: GoogleFonts.poppins(
                              color: secondary,
                            ),
                          ),
                        ),
                      );
                    }),

                    /*-------------------------------------------*/
                    //fonction du candidat
                    GetBuilder<CandidatController>(
                        builder: (CandidatController) {
                      return Container(
                        margin: const EdgeInsets.only(
                                left: 60, right: 60, top: 60, bottom: 5)
                            .r,
                        //padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 5),
                        height: 150.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
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
                              text: candidatController.fonction.value),
                          onChanged: (value) => candidatController
                              .changeFonctionController(value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 30).r,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.event_note,
                              color: secondary,
                            ),
                            hintText: 'Veillez entrez la fonction du candidat',
                            hintStyle: GoogleFonts.poppins(
                              color: secondary,
                            ),
                          ),
                        ),
                      );
                    }),

                    /*-------------------------------------------*/
                    //email du candidat
                    GetBuilder<CandidatController>(
                        builder: (CandidatController) {
                      return Container(
                        margin: const EdgeInsets.only(
                                left: 60, right: 60, top: 60, bottom: 5)
                            .r,
                        //padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 5),
                        height: 150.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
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
                              text: candidatController.adresseMail.value),
                          onChanged: (value) => candidatController
                              .changeAdresseMailController(value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 30).r,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: secondary,
                            ),
                            hintText:
                                'Veillez entrez l\'adresse mail du candidat',
                            hintStyle: GoogleFonts.poppins(
                              color: secondary,
                            ),
                          ),
                        ),
                      );
                    }),

                    /*-------------------------------------------*/
                    space,
                    space,
                    //button d'ajout section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 550.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(40),
                              right: Radius.circular(40),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              candidatController.ajouterUnNouveauCandidat();
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(40),
                                right: Radius.circular(40),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Ajouter',
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
                    /*-------------------------------------------*/
                  ],
                ),
                /*-------------------------------*/
              ],
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
