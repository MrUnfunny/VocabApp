class Email {
  String emailAddress;
  Email(this.emailAddress);

  static validate(emailAddress) {
    final validEmail = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (emailAddress != null && emailAddress != '') {
      return validEmail.hasMatch(emailAddress);
    }
    return true;
  }
}
