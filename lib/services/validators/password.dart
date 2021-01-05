///simple validation of password based on length.

class Password {
  String password;
  Password(this.password);

  static validate(password) {
    if (password != null && password != '') {
      if (password.length >= 6) {
        return true;
      }
      return false;
    }
    return true;
  }
}
