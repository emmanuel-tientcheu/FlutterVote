import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:vote/electeur_path/motDePasseOublie.dart';
//import 'package:vote/electeur_path/step1Inscription.dart';

import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'inscriptionController.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class AllPageInscriptionElecteur extends StatefulWidget {
  final String role;
  const AllPageInscriptionElecteur({Key? key, required this.role}) : super(key: key);
  @override
  State<AllPageInscriptionElecteur> createState() =>
      _AllPageInscriptionElecteurState();
}

class _AllPageInscriptionElecteurState extends State<AllPageInscriptionElecteur> {

  final Mycontroller name = Get.put(Mycontroller());
  final nameController = TextEditingController();
  final InscriptionController inscriptionController = Get.put(InscriptionController());
  bool visible = true;

  final List<String> _Language = ["fr", "en"];
  String _selectedItem = "fr";
  final PageController _pageController = PageController(initialPage: 0);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //select image
  File? _image; //fichier choisis
  File? _image2;
  PickedFile? _pickedFile;
  PickedFile? _pickedFile2;
  final _picker = ImagePicker();
  //loading
  bool _isloading = false;
  //role
  String roleRecive = "";
  @override
  void initState() {
    super.initState();
    roleRecive = widget.role;
    print(roleRecive);
  }
  Future<void> _pickImage() async {
    try {
      if (_pickedFile == null) {
        _pickedFile = await _picker.getImage(source: ImageSource.gallery);
        if (_pickedFile != null) {
          setState(() {
            _image = File(_pickedFile!.path);
          });
        }
      } else {
        _pickedFile2 = await _picker.getImage(source: ImageSource.gallery);
        if (_pickedFile2 != null) {
          setState(() {
            _image2 = File(_pickedFile2!.path);
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print, unnecessary_brace_in_string_interps
      print("error selected image: ${e}");
    }
  } //fichier selectionner maintenant le fichier choisis

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: _scaffoldKey,
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
            body: _isloading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Color(0xFF0CB7F2),
                  ))
                : PageView(
                    controller: _pageController,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            /*---------------------*/
                            TextField(
                              controller: TextEditingController(
                                  text: inscriptionController
                                      .nameController.value),
                              onChanged: (value) => inscriptionController
                                  .changeNameController(value),
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
                                  text: inscriptionController
                                      .emailController.value),
                              onChanged: (value) => inscriptionController
                                  .changeEmailController(value),
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
                                  text: inscriptionController
                                      .ageController.value),
                              onChanged: (value) => inscriptionController
                                  .changeAgeController(value),
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
                                  text: inscriptionController
                                      .numTelController.value),
                              onChanged: (value) => inscriptionController
                                  .changeNumTelController(value),
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
                            SizedBox(height: ScreenUtil().setHeight(50)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pièces d\'identité',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: const Color(0xFF3F3F3F),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(190),
                                      width: ScreenUtil().setWidth(190),
                                      child: MaterialButton(
                                        onPressed: () {
                                          _pickImage();
                                        },
                                        height: ScreenUtil().setHeight(190),
                                        color: const Color(0xFF53d4ff),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 35.0,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /*-------------------*/
                                    Container(
                                      height: ScreenUtil().setHeight(190),
                                      width: ScreenUtil().setWidth(190),
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: const BoxDecoration(),
                                      child: _pickedFile != null
                                          ? Image.file(
                                              File(_pickedFile!.path),
                                              fit: BoxFit.cover,
                                            )
                                          : const Text(""),
                                    ),
                                    /*-------------------*/
                                    Container(
                                      height: ScreenUtil().setHeight(190),
                                      width: ScreenUtil().setWidth(190),
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: const BoxDecoration(),
                                      child: _pickedFile2 != null
                                          ? Image.file(
                                              File(_pickedFile2!.path),
                                              fit: BoxFit.cover,
                                            )
                                          : const Text(""),
                                    ),
                                    /*-------------------*/
                                  ],
                                ),
                              ],
                            ),
                            /*-----------------*/
                            SizedBox(height: ScreenUtil().setHeight(300)),
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
                                side: BorderSide(
                                    color: Color(0xFF53d4ff), width: 2),
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
    // ignore: avoid_print
    print("salut");

    setState(() {
      _isloading = true;
    });

    try {
      String nom = inscriptionController.nameController.value;
      String identifiantnumero =
          inscriptionController.identificationNumberController.value;
      String email = inscriptionController.emailController.value;
      String mdp = inscriptionController.motDePasseController.value;
      // int age = int.parse(inscriptionController.ageController.value);
      String citoyennete = inscriptionController.citoyenneteController.value;
      String telephone = inscriptionController.numTelController.value;
      String residence = inscriptionController.residenceController.value;
      String language = inscriptionController.languageController.value;

      List<int> imageBytes = _image!.readAsBytesSync();

      String base64Image = base64Encode(imageBytes);

      final imageStream = http.ByteStream(_image!.openRead());
      final imageLength = await _image!.length();

      final image = http.MultipartFile.fromBytes(
        'pieces_jointes[]',
        File(_image!.path).readAsBytesSync(),
        filename: _image!.path,
      );

      final image2 = http.MultipartFile.fromBytes(
        'pieces_jointes[]',
        File(_image2!.path).readAsBytesSync(),
        filename: _image2!.path,
      );

      const url = "http://10.0.2.2:8000/api/user";
      final uri = Uri.parse(url);
      final formData = http.MultipartRequest('POST', Uri.parse(url));
      formData.fields.addAll({
        "complete_name": nom,
        "email": email,
        "identification_number": identifiantnumero,
        "password": mdp,
        "age": "25",
        "citoyennete": citoyennete,
        "telephone": telephone,
        "residence": residence,
        "language": language,
        "role": roleRecive,
      });
      formData.files.add(image);
      formData.files.add(image2);
      final response = await formData.send();
      if (response.statusCode == 201) {
        setState(() {
          _isloading = false;
        });
        print("Upload success");
        showSucessMessage('l\'opperation a réussi vous pouvez vos connecter');
      } else {
        setState(() {
          _isloading = false;
        });
        print("Upload failed with status ${response.statusCode}");
        showAlertError(
            'l\'oppération de céation a echoué verifier vos informations');
      }

      final body = {
        "complete_name": nom,
        "email": email,
        "identification_number": identifiantnumero,
        "password": mdp,
        // "age": age,
        "citoyennete": citoyennete,
        "telephone": telephone,
        "residence": residence,
        "language": language,
        "role": "electeur",
        "pieces_jointes": imageBytes
      };
      // ignore: avoid_print
      //  print(body);
      /* const url = "http://10.0.2.2:8000/api/user";
      final uri = Uri.parse(url);*/
      /*var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        print('User created successfully: ${response.body}');
        showSucessMessage('l\'opperation a réussi vous pouvez vos connecter');
      } else {
        print('Failed to create user. Status code: ${response.body}');
        showErrorMessage(
            'l\'oppération de céation a echoué verifier vos informations');
      }*/
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      showAlertError("Error opperation");
      print("Error opperation: $e");
    }
  }

   void showAlertError(String message) {
    QuickAlert.show(
        context: context,
        title: "Oppération reussie",
        text: message,
        type: QuickAlertType.error);
  }

  void showSucessMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Creation de compte reussie'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then(
      (value) => Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Echec de la création'),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void sendData2() async {
    String nom = inscriptionController.nameController.value;
    final data = {"complete_name": nom};
    try {
      final dio = Dio();

      final response =
          await dio.post('http://10.0.2.2:8000/api/user', data: data);
      print("bonjour");
      print(response.data);
    } catch (e) {
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
