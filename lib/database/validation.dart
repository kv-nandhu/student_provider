class Validations {
  static String? nameValidator(
    String? value,
  ) {
    final trimmedvalue = value?.trim();

    if (trimmedvalue == null || trimmedvalue.isEmpty) {
      return 'Enter Your Name';
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

    if (!nameRegExp.hasMatch(trimmedvalue)) {
      return 'Full Name only contains letters';
    }
    return null;
  }

  static String? phoneValidator(
    String? value,
  ) {
    final trimmedvalue = value?.trim();

    if (trimmedvalue == null || trimmedvalue.isEmpty) {
      return 'Enter your Phone Number';
    }

    final RegExp phoneRegExp =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    if (!phoneRegExp.hasMatch(trimmedvalue)) {
      return 'Enter your Number';
    }
    return null;
  }
 
   static String? ageValidator(
    String? value,
  ) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Enter your Age';
    }

    final age = int.tryParse(trimmedValue);

    if (age == null || age <= 0 || age > 150) {
      return 'Enter a valid Age';
    }
    return null;
  }

  static String? addressValidator(
    String? value,
  ) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Enter your Address';
    }

    final RegExp addressRegExp = RegExp(r'^.*,\s*[0-9]{6}$');

    if (!addressRegExp.hasMatch(trimmedValue)) {
      return 'Enter a valid Address with Pin Code';
    }
    return null;
  }
}
