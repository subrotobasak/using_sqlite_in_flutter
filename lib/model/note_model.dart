
class Note {
  final int? id;
  final String title;

  const Note({required this.id, required this.title});
  

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(id: json['id'], title: json['title']);



  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
