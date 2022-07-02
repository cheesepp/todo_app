class Task {
  final String title;
  final String id;
  bool? isDone;
  bool? isDeleted;

  Task({required this.title, required this.id, this.isDeleted, this.isDone}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({String? id, String? title, bool? isDone, bool? isDeleted}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      isDeleted: json['isDeleted'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDeleted': isDeleted,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isDeleted,
        isDone,
      ];
}
