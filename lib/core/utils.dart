class Utils{

  static String convertToUpperCase({required String input}){
    RegExp regExp = RegExp(r'(_\w)');

    // Replace matches with their uppercase version (excluding the underscore)
    String result = input
        .split(',')
        .map((word) => word.replaceAllMapped(
      regExp,
          (match) => match.group(0)![1].toUpperCase(),
    ).replaceFirstMapped(
      RegExp(r'^\w'),
          (match) => match.group(0)!.toUpperCase(),
    ))
        .join(',');
    return result;
  }
}