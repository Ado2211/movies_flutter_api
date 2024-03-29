class Movie {
  final String id;
  final String title;
  final String posterUrl;
 double? rating;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
   this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['titleText']['text'],
      posterUrl: json['primaryImage']['url'],
      
    );
  }

}
