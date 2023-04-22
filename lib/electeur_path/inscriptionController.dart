import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InscriptionController extends GetxController {
  var nameController = "".obs;
  var emailController = "".obs;
  var prenomController = "".obs;
  var identificationNumberController = "".obs;
  var ageController = "".obs;
  var telephoneController = "".obs;
  var residenceController = "".obs;
  var motDePasseController = "".obs;
  var citoyenneteController = "".obs;
  var numTelController = "".obs;
  var languageController = "fr".obs;

  /*---------fileController--------------*/
  PickedFile? _pickedFile;
  PickedFile? pathimage;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  Future<void> pickImage() async {
    try {
      _pickedFile = await _picker.getImage(source: ImageSource.gallery);
      pathimage = _pickedFile;
      update();
    } catch (e) {
      // ignore: avoid_print, unnecessary_brace_in_string_interps
      print("error selected image: ${e}");
    }
  }

  changeNameController(value) {
    nameController.value = value;
  }

  changePrenomController(value) {
    prenomController.value = value;
  }

  changeIdentificationController(value) {
    identificationNumberController.value = value;
  }

  changeAgeController(value) {
    ageController.value = value;
  }

  changeEmailController(value) {
    emailController.value = value;
  }

  changeMotDePasseController(value) {
    motDePasseController.value = value;
  }

  changeResidenceController(value) {
    residenceController.value = value;
  }

  changeCitoyenneteController(value) {
    citoyenneteController.value = value;
  }

  changeNumTelController(value) {
    numTelController.value = value;
  }

  changeLanguageController(value) {
    languageController.value = value;
  }
}
