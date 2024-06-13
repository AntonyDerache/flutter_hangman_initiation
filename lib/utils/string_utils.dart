class StringUtils {
  static String replaceCharAt(String oldString, int index, String newChar) =>
      oldString.replaceRange(index, index + 1, newChar);
}
