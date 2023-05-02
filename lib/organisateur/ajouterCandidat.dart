import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AjouterCandidatVote extends StatefulWidget {
  const AjouterCandidatVote({super.key});

  @override
  State<AjouterCandidatVote> createState() => _AjouterCandidatVoteState();
}

class _AjouterCandidatVoteState extends State<AjouterCandidatVote> {
  Color primary = const Color(0xFF0CB7F2);
  Color secondary = const Color(0xFF3F3F3F);
  /*--------------------------------------------*/
  //input de la recherche
  final searchController = TextEditingController();
  /*--------------------------------------------*/
  final List _names = [
    {"name": "emma charles charles charles charles", "_isChecked": false},
    {"name": "charles", "_isChecked": false},
    {"name": "yvan", "_isChecked": false},
    {"name": "toto", "_isChecked": false},
    {"name": "cedric", "_isChecked": false},
    {"name": "franck", "_isChecked": false},
    {"name": "henry", "_isChecked": false},
    {"name": "jean", "_isChecked": false},
    {"name": "jack", "_isChecked": false},
    {"name": "romaric", "_isChecked": false},
  ];
  List _filtered = [];

  /*--------------------------------*/
  //fonction de recherche
  void filterNames(String query) {
    setState(() {
      _filtered = _names
          .where((name) =>
              name['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filtered = _names;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                /*-------------------------------------*/
                //search bar
                Container(
                  width: double.infinity,
                  height: 120.h,
                  margin: const EdgeInsets.all(30).w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: primary,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      filterNames(value);
                    },
                    controller: searchController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 10).r,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondary,
                      ),
                      hintText: "Recherche",
                      hintStyle: GoogleFonts.poppins(
                        color: secondary,
                      ),
                    ),
                  ),
                ),
                //end search bar
                /*-------------------------------------*/

                /*-------------------------------------*/
                //liste des candidats present dans le systeme
                Container(
                  margin: const EdgeInsets.all(30).w,
                  width: double.infinity,
                  height: 1500.h,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filtered.length,
                            itemBuilder: (context, index) {
                              final candidat = _filtered[index] as Map;
                              //final id = candidat["id"];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      //affichage photo de profile

                                      Container(
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

                                      //end

                                      //information
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 80).r,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                candidat["name"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 50.sp,
                                                  color: secondary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                candidat["name"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 50.sp,
                                                  color: secondary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: 90.w,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          color: primary,
                                        ),
                                        child:InkResponse(
                                          radius: 20,
                                          onTap: () {
                                            setState(() {
                                              candidat["_isChecked"] =
                                                  !candidat["_isChecked"];
                                            });
                                          },
                                          child: candidat["_isChecked"]
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  )
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                //end list candidats
                /*-------------------------------------*/
              ],
            ),
          ),
        );
      },
    );
  }
}
