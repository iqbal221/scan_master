class HistoryModel {
  final int? id;
  final String content;
  final String type;
  final String format;
  final bool isFavorite;
  final DateTime createdAt;

  const HistoryModel({
    this.id,
    required this.content,
    required this.type,
    required this.format,
    this.isFavorite = false,
    required this.createdAt,
  });

  /// Copy With
  HistoryModel copyWith({
    int? id,
    String? content,
    String? type,
    String? format,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      format: format ?? this.format,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert to SQLite Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'format': format,
      'isFavorite': isFavorite ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create object from SQLite Map
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] as int?,
      content: map['content'] as String,
      type: map['type'] as String,
      format: map['format'] as String,
      isFavorite: (map['isFavorite'] ?? 0) == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  /// JSON Support
  Map<String, dynamic> toJson() => toMap();

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel.fromMap(json);
  }

  @override
  String toString() {
    return '''
HistoryModel(
  id: $id,
  content: $content,
  type: $type,
  format: $format,
  isFavorite: $isFavorite,
  createdAt: $createdAt,
)
''';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          type == other.type &&
          format == other.format &&
          isFavorite == other.isFavorite &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      Object.hash(id, content, type, format, isFavorite, createdAt);
}
