class Diary {
  final String createdAt;
  String formattedDate;
  final bool bookmark;
  final String font;
  final String title;
  final String content;
  final List<String> imageUrls;
  final String output;
  final String? userAnswer;

  Diary({
    required this.createdAt,
    required this.formattedDate,
    required this.bookmark,
    required this.font,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.output,
    this.userAnswer,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      createdAt: json['created_at'],
      formattedDate: '', // 초기값
      bookmark: json['bookmark'] ?? false,
      font: json['font'],
      title: json['title'],
      content: json['content'],
      imageUrls: json['imageIds'] != null
          ? List<String>.from(json['imageIds'])
          : [], // null이면 빈 리스트 할당
      output: json['output'] ?? '',
      userAnswer: json['user_answer'] ?? '',
    );
  }
}
