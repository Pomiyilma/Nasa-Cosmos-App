class ApodModel{
  final String title;
  final String explanation;
  final String url;
  final String mediaType;
  final String date;
  final String? copyright;

  ApodModel({
    required this.title,
    required this.explanation,
    required this.url,
    required this.mediaType,
    required this.date,
    this.copyright,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json){
    return ApodModel(
      title: json['title'] ?? 'No Title',
      explanation: json['explanation'] ?? '',
      url: json['url'] ?? '',
      mediaType: json['media_type'] ?? 'image',
      date: json['date'] ?? '',
      copyright: json['copyright'],
    );
  }
}