import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CandidatController extends GetxController {
  final List<Candidat> _listeCandidat = [];
  var nom = "".obs;
  var age = "".obs;
  var adresseMail = "".obs;
  var fonction = "".obs;

  List<Candidat> get listeCandidat => _listeCandidat;

  changeNomController(value) => nom.value = value;
  changeAgeController(value) => age.value = value;
  changeFonctionController(value) => fonction.value = value;
  changeAdresseMailController(value) => adresseMail.value = value;

  ajouterUnNouveauCandidat() {
    if (nom.value.length < 2 ||
        age.value.length < 2 ||
        fonction.value.length < 2 ||
        adresseMail.value.length < 2) {
      Get.snackbar(
        "Un champ a été oublié",
        "vous devez remplir tout les champs pour ajouter un cadidat",
        icon: const Icon(Icons.alarm),
        backgroundColor: const Color.fromARGB(127, 244, 67, 54),
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 5),
      );
      nom.value = "";
      age.value = "";
      adresseMail.value = "";
      fonction.value = "";
      update();
    } else {
      _listeCandidat.add(
          Candidat(nom.value, age.value, fonction.value, adresseMail.value));
      nom.value = "";
      age.value = "";
      adresseMail.value = "";
      fonction.value = "";
      Get.snackbar(
        "Oppération Réussi",
        "L'utilisateur a bien été enregistrer",
        icon: const Icon(Icons.alarm),
        backgroundColor: const Color.fromARGB(115, 12, 185, 242),
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
      update();
      for (Candidat candidat in _listeCandidat) {
        print(
            'Nom: ${candidat.nom}, Age: ${candidat.age}, Adresse mail: ${candidat.adresseMail}');
      }
    }
  }

  retirerUnCandidat(int index) {
    _listeCandidat.removeAt(index);
  // print(index);
    update();
  }
}

class Candidat {
  String nom = "";
  String age = "";
  String fonction = "";
  String adresseMail = "";

  Candidat(this.nom, this.age, this.fonction, this.adresseMail);
}
