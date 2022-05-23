class Validator {
  Validator._();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static bool validateEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool validatePw(String pw) {
    return pw.length >= 6;
  }
}
