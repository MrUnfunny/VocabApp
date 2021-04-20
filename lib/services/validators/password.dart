///simple validation of password based on length.

class Password {
  Password(this.password);

  String password;

  static bool validate(String password) {
    if (password != null && password != '') {
      if (password.length >= 6 != null) {
        return true;
      }
      return false;
    }
    return true;
  }
}
