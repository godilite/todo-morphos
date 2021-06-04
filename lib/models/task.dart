class Task {
  String id;
  String title;
  String desc;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.desc,
    required this.completed,
  });
  factory Task.fromMap(map) => Task(
        id: map.id,
        title: map['title'],
        desc: map['description'],
        completed: map['completed'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': desc,
        'completed': completed,
      };
}
