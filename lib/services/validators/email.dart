///class for validation of email using regular Expression

class Email {
  Email(this.emailAddress);

  String emailAddress;

  static bool validate(String emailAddress) {
    final validEmail = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (emailAddress != null && emailAddress != '') {
      return validEmail.hasMatch(emailAddress);
    }
    return true;
  }
}
