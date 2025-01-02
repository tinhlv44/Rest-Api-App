class Todo {
  final String sId;
  final String title;
  final String? description;
  final bool? isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.sId,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Todo.fromJson(Map<String, dynamic> json) {
    if (json['_id'] == null || json['title'] == null) {
      throw Exception('Invalid JSON data: Missing required fields');
    }
    return Todo(
      sId: json['_id'],
      title: json['title'],
      description: json['description'] ?? 'No description',
      isCompleted: json['is_completed'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Todo copyWith({
    String? sId,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      sId: sId ?? this.sId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
