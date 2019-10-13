import 'package:community_application/Models/DateTimeObject.dart';
import 'package:community_application/Models/Person.dart';
import 'package:community_application/Utils/DateUtils.dart';

class Article extends DatetimeObject {
  String title;
  String content;
  DateTime date;
  Person author;
  String imageUrl;

  Article({
    this.date,
    this.title,
    this.content,
    this.imageUrl,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
      date: DateTime.parse(parsedJson['date']).toUtc(),
      title: parsedJson['title'],
      content: parsedJson['article'],
      imageUrl: parsedJson['image_url'],
      author: new Person.fromJson(parsedJson['author']),
    );
  }

  @override
  String getTitle() {
    return this.title;
  }

  @override
  DateTime getComparisonDate() {
    return this.date.toUtc();
  }

  @override
  bool isInRange(DateTime startDate, DateTime endDate) {
    if (endDate == null) {
      return isOnOrAfter(this.date, startDate.toUtc());
    }

    if (startDate == null) {
      return isOnOrBefore(this.date, endDate.toUtc());
    }

    return isOnOrAfter(this.date, startDate.toUtc()) &&
        isOnOrBefore(this.date, endDate.toUtc());
  }
}
