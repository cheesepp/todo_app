class Task {
  final String id;
  final String title;
  final String description;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task(
      {required this.title,
      required this.description,
      required this.id,
      required this.date,
      this.isFavorite,
      this.isDeleted,
      this.isDone}) {
    isFavorite = isFavorite ?? false;
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith(
      {String? title,
      String? description,
      String? id,
      String? date,
      bool? isFavorite,
      bool? isDone,
      bool? isDeleted}) {
    return Task(
      date: date ?? this.date,
      description: description ?? this.description,
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      description: json['description'] ?? '',
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      isDeleted: json['isDeleted'],
      isFavorite: json['isFavorite'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'title': title,
      'date': date,
      'isFavorite': isFavorite,
      'isDeleted': isDeleted,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        description,
        isFavorite,
        isDeleted,
        isDone,
      ];
}
