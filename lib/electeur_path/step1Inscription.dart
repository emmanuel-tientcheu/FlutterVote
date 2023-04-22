import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur_path/motDePasseOublie.dart';

import 'package:get/get.dart';
import 'inscriptionController.dart';
import 'package:http/http.dart' as http;

class Setp1InscriptionElecteur extends StatefulWidget {
  const Setp1InscriptionElecteur({super.key});
  @override
  State<Setp1InscriptionElecteur> createState() =>
      _Setp1InscriptionElecteurState();
}

class _Setp1InscriptionElecteurState extends State<Setp1InscriptionElecteur> {
  final InscriptionController inscriptionController =
      Get.put(InscriptionController());
  bool visible = true;
  final List<String> _Language = ["fr", "en"];
  String _selectedItem = "fr";
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
            body: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*------------------------------ */
                  TextField(
                    controller: TextEditingController(
                        text: inscriptionController.residenceController.value),
                    onChanged: (value) =>
                        inscriptionController.changeResidenceController(value),
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
                        inscriptionController.changeLanguageController(value);
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
          ),
        );
      },
    );
  }

  Future<void> submitData() async {
    print("bonjour");
    final body = {
      "complete_name": inscriptionController.nameController.value,
      "email": inscriptionController.emailController.value,
      "identification_number":
          inscriptionController.identificationNumberController.value,
      "password": inscriptionController.motDePasseController.value,
      "age": int.parse(inscriptionController.ageController.value),
      "citoyennete": inscriptionController.citoyenneteController.value,
      "telephone": inscriptionController.telephoneController.value,
      "residence": inscriptionController.residenceController.value,
      "language": inscriptionController.languageController.value
    };

    const url = "http://127.0.0.1:8000/api/user";
    final uri = Uri.parse(url);

    try {
      var response = await http.post(
        uri,
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print("Error opperation: $e");
    }
  }
}
