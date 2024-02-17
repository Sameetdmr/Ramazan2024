class HadithModel {
  final String category;
  final String hadith;
  final String author;
  final String id;

  HadithModel({
    required this.category,
    required this.hadith,
    required this.author,
    required this.id,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      category: json['category'],
      hadith: json['hadith'],
      author: json['author'],
      id: json['id'],
    );
  }
}
