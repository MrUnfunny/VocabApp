class Email {
  String emailAddress;
  Email(this.emailAddress);

  validate(emailAddress) {
    print("called $emailAddress");
    final validEmail = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (emailAddress != null) return validEmail.hasMatch(emailAddress);
    print(emailAddress);
    return false;
  }
}
