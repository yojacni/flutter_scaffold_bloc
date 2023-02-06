class ValidationPatterns {
  static final passwordRegExp = RegExp(
    r'^(?=.{8,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$',
  );
  static final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final zipCodeRexExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');
}
