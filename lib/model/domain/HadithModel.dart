// ignore_for_file: public_member_api_docs

final class HadithModel {
  HadithModel({
    required this.category,
    required this.hadith,
    required this.author,
    required this.id,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      category: json['category'] as String,
      hadith: json['hadith'] as String,
      author: json['author'] as String,
      id: json['id'] as String,
    );
  }
  final String category;
  final String hadith;
  final String author;
  final String id;
}
