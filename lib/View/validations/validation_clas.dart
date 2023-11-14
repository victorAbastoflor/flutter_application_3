class ValidationHelper {
  static bool areFieldsFilled(
      String text1, String text2, dynamic selectedRole) {
    return text1.isNotEmpty && text2.isNotEmpty && selectedRole != null;
  }
}
