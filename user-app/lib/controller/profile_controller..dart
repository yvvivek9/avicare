import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userType = Rxn<String>();
  final gender = Rxn<String>();
  final birthDate = Rxn<DateTime>();
  final weight = Rxn<double>();
  final height = Rxn<double>();
  final weightUnit = RxString('kgs');
  final heightUnit = RxString('cm');
  RxBool isPopupActive = false.obs;

  void setUserType(String? value) => userType.value = value;

  void setGender(String? value) => gender.value = value;

  void setBirthDate(DateTime? value) => birthDate.value = value;

  void setWeight(String value) => weight.value = double.tryParse(value);

  void setHeight(String value) => height.value = double.tryParse(value);

  void toggleWeightUnit(String unit) => weightUnit.value = unit;

  void toggleHeightUnit(String unit) => heightUnit.value = unit;
}
