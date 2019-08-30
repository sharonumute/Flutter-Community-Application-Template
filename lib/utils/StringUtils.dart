String getInitials(String sentence, {String intitialsSeparator = ""}) {
  String initials = "";
  List<String> words = sentence.split(" ");
  for (var word in words) {
    String firstLetter = new String.fromCharCode(word.runes.first);
    initials = initials + intitialsSeparator + firstLetter;
  }
  return initials;
}
