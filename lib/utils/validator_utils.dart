class ValidatorUtils {
  static String? nameValidator(value) {
    //Name should be contains only letters and required
    RegExp regex = RegExp(r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$');
    if (value.isEmpty) return 'Enter a pet name';
    if (!regex.hasMatch(value)) return 'Pet name not valide';
    return null;
  }
}