/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur_path/motDePasseOublie.dart';

class Setp1InscriptionElecteur extends StatefulWidget {
  const Setp1InscriptionElecteur({super.key});
  @override
  State<Setp1InscriptionElecteur> createState() =>
      _Setp1InscriptionElecteurState();
}

class _Setp1InscriptionElecteurState extends State<Setp1InscriptionElecteur> {
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
            body: Column(
              children: [
               SizedBox(height: ScreenUtil().setWidth(150)),
               Text('yes')
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur_path/motDePasseOublie.dart';
import 'package:vote/electeur_path/step1Inscription.dart';

class AllPageInscriptionElecteur extends StatefulWidget {
  const AllPageInscriptionElecteur({super.key});
  @override
  State<AllPageInscriptionElecteur> createState() =>
      _AllPageInscriptionElecteurState();
}

class _AllPageInscriptionElecteurState
    extends State<AllPageInscriptionElecteur> {
  final PageController _pageController = PageController(initialPage: 0);
  final _formKey = GlobalKey<FormState>();
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
            body: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                          ),
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                          ),
                          onSaved: (value) {},
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (value) {
                     
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                     
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Submit the form data
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_pageController.page! < 1) {
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
}
*/
