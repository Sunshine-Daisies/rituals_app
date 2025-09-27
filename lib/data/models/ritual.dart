import 'package:equatable/equatable.dart';

class Ritual extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String time; // 24h format: "21:30"
  final List<String> days; // ["monday", "tuesday", ...]
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ritual({
    required this.id,
    required this.userId,
    required this.name,
    required this.time,
    required this.days,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ritual.fromJson(Map<String, dynamic> json) {
    return Ritual(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      days: List<String>.from(json['days'] as List),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'time': time,
      'days': days,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Ritual copyWith({
    String? id,
    String? userId,
    String? name,
    String? time,
    List<String>? days,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ritual(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      time: time ?? this.time,
      days: days ?? this.days,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, name, time, days, createdAt, updatedAt];
}