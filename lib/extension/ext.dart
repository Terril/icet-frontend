String filterNull(String? input) {
  if (input == null) {
    return "";
  }
  return input;
}

List<T> filterNullList<T>(List<T>? input) {
  if (input == null || input.isEmpty) {
    return List.empty();
  }
  return input;
}