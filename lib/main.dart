import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vote/electeur_path/connexionElecteur.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
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
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
              children: [
                Center(
                  child: imageSection,
                ),
                SizedBox(height: 300.h),
                const Expanded(
                  child: SelectRole(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget imageSection = SizedBox(
  height: 640.h,
  width: 640.w,
  child: Image.asset('assets/images/imageDeVote.png'),
);

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});
  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
   String role = "   ";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10).r,
          child: Column(
            children: [
              Text(
                'Se connecter en tant que',
                style: GoogleFonts.poppins(
                  fontSize: 80.sp,
                ),
              ),
              SizedBox(height: 110.h),
              Container(
                margin: const EdgeInsets.fromLTRB(70, 0, 70, 0).r,
                child: MaterialButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      role = "electeur";
                    });
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnexionElecteur(role:role),
                      ),
                    );
                   
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
                      'Electeur',
                      style: GoogleFonts.poppins(
                        fontSize: 60.sp,
                        color: const Color(0xFF53d4ff),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              Container(
                margin: const EdgeInsets.fromLTRB(70, 0, 70, 0).r,
                child: MaterialButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                     setState(() {
                      role = "organisateur";
                    });
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnexionElecteur(role:role),
                      ),
                    );
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
                      'Organisateurs',
                      style: GoogleFonts.poppins(
                        fontSize: 60.sp,
                        color: const Color(0xFF53d4ff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
