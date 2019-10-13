class Person {
  String name;
  String imageUrl;
  String personInformation;

  Person({
    this.name,
    this.imageUrl,
    this.personInformation,
  });

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    return Person(
      name: parsedJson['name'],
      imageUrl: parsedJson['image_url'],
      personInformation: parsedJson['person_information'],
    );
  }
}
