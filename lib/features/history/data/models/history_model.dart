class HistoryModel {
  final int? id;
  final String content;
  final String type;
  final String format;
  final bool isFavorite;
  final DateTime scannedAt;

  const HistoryModel({
    this.id,
    required this.content,
    required this.type,
    required this.format,
    this.isFavorite = false,
    required this.scannedAt,
  });

  /// Copy With
  HistoryModel copyWith({
    int? id,
    String? content,
    String? type,
    String? format,
    bool? isFavorite,
    DateTime? scannedAt,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      format: format ?? this.format,
      isFavorite: isFavorite ?? this.isFavorite,
      scannedAt: scannedAt ?? this.scannedAt,
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
      'scannedAt': scannedAt.toIso8601String(),
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
      scannedAt: DateTime.parse(map['scannedAt'] as String),
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
  scannedAt: $scannedAt,
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
          scannedAt == other.scannedAt;

  @override
  int get hashCode =>
      Object.hash(id, content, type, format, isFavorite, scannedAt);
}
