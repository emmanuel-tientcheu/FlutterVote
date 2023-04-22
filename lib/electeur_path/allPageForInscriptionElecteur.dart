import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur_path/motDePasseOublie.dart';
import 'package:vote/electeur_path/step1Inscription.dart';

import 'package:get/get.dart';
import 'inscriptionController.dart';
import 'package:http/http.dart' as http;

class AllPageInscriptionElecteur extends StatefulWidget {
  const AllPageInscriptionElecteur({super.key});
  @override
  State<AllPageInscriptionElecteur> createState() =>
      _AllPageInscriptionElecteurState();
}

class _AllPageInscriptionElecteurState
    extends State<AllPageInscriptionElecteur> {
  final Mycontroller name = Get.put(Mycontroller());
  final nameController = TextEditingController();
  final InscriptionController inscriptionController =
      Get.put(InscriptionController());
  bool visible = true;
  final List<String> _Language = ["fr", "en"];
  String _selectedItem = "fr";
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFF0CB7F2),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              title: Text(
                'S\'inscrire',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: PageView(
              controller: _pageController,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      /*---------------------*/
                      TextField(
                        controller: TextEditingController(
                            text: inscriptionController.nameController.value),
                        onChanged: (value) =>
                            inscriptionController.changeNameController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Nom',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: TextEditingController(
                            text: inscriptionController.emailController.value),
                        onChanged: (value) =>
                            inscriptionController.changeEmailController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: inscriptionController
                                .identificationNumberController.value),
                        onChanged: (value) => inscriptionController
                            .changeIdentificationController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Numero d\'identifications',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        obscureText: visible,
                        controller: TextEditingController(
                            text: inscriptionController
                                .motDePasseController.value),
                        onChanged: (value) => inscriptionController
                            .changeMotDePasseController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Mot de passe',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: visible
                                ? const Icon(
                                    Icons.visibility,
                                  )
                                : const Icon(Icons.visibility_off),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: inscriptionController.ageController.value),
                        onChanged: (value) => inscriptionController
                            .changeResidenceController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Age',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        controller: TextEditingController(
                            text: inscriptionController
                                .citoyenneteController.value),
                        onChanged: (value) => inscriptionController
                            .changeCitoyenneteController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Nationalité',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: inscriptionController.numTelController.value),
                        onChanged: (value) =>
                            inscriptionController.changeNumTelController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Télephone',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*---------------------*/
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*------------------------------ */
                      TextField(
                        controller: TextEditingController(
                            text: inscriptionController
                                .residenceController.value),
                        onChanged: (value) => inscriptionController
                            .changeResidenceController(value),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, top: 15),
                          labelText: 'Résidence',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: const Color(0xFF3F3F3F),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0CB7F2),
                            ),
                          ),
                        ),
                      ),
                      /*-----------------*/
                      SizedBox(height: ScreenUtil().setWidth(50)),
                      DropdownButton<String>(
                        hint: const Text('Select item'),
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: const Color(0xFF3F3F3F),
                        ),
                        value: _selectedItem,
                        underline: Container(
                          height: 2,
                          width: 2,
                          color: const Color(0xFF53d4ff),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedItem = value!;
                            inscriptionController
                                .changeLanguageController(value);
                          });
                        },
                        items: _Language.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                      /*-----------------*/
                      SizedBox(height: ScreenUtil().setHeight(100)),
                      MaterialButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          submitData();
                        },
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
                          ),
                          side: BorderSide(color: Color(0xFF53d4ff), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            'S\'inscrire',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: const Color(0xFF53d4ff),
                            ),
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_pageController.page! < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: const Icon(Icons.arrow_forward),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        );
      },
    );
  }

  Future<void> submitData() async {
    print("salut");
    String nom = inscriptionController.nameController.value;
    String identifiantConnection = inscriptionController.identificationNumberController.value;
    final body = {"complete_name": nom};

    const url = "http://10.0.2.2:8000/api/user";
    final uri = Uri.parse(url);

    try {
      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('User created successfully');
      } else {
        print('Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error opperation: $e");
    }
  }

  void showSucessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sendData2() async {
     String nom = inscriptionController.nameController.value;
     final data = {"complete_name": nom};
    try {
      final dio = Dio();
     
      final response = await dio.post('http://10.0.2.2:8000/api/user', data: data);
      print("bonjour");
      print(response.data);

    }catch (e) {
      print("Error send2 : $e");
    }
  }
}

Widget step1 = Padding(
  padding: const EdgeInsets.only(left: 15, right: 15),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 15, top: 15),
          labelText: 'Email',
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: const Color(0xFF3F3F3F),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF0CB7F2),
            ),
          ),
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(50)),
      Container()
    ],
  ),
);

/*
 Container(
                  child: Stepper(
                    currentStep: _currentStep,
                    onStepTapped: (int index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    onStepContinue: () {
                      setState(() {
                        if (_currentStep < _steps.length - 1) {
                          _currentStep++;
                        }
                      });
                    },
                    onStepCancel: () {
                      setState(() {
                        if (_currentStep > 0) {
                          _currentStep--;
                        }
                      });
                    },
                    steps: _steps,
                  ),
                ),

                 TextField(
                  controller: TextEditingController(text: name.name.value),
                  onChanged: (value) => name.change(value),
                  decoration: InputDecoration(
                    
                    contentPadding: const EdgeInsets.only(bottom: 15, top: 15),
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: const Color(0xFF3F3F3F),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0CB7F2),
                      ),
                    ),
                  ),
                ),
*/

class Mycontroller extends GetxController {
  var name = "".obs;

  change(value) {
    name.value = value;
  }
}
