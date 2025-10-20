import 'package:cloud_firestore/cloud_firestore.dart';

enum ChildGender { male, female, other }

class ChildProfile {
  final String id;
  final String name;
  final int age;
  final ChildGender gender;
  final String? avatarUrl;
  final String parentId;
  final Map<String, int> levels; // Category -> Level mapping
  final int totalStars;
  final List<String> unlockedAchievements;
  final int dailyPlayTimeLimit; // in minutes
  final DateTime lastActive;

  ChildProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.avatarUrl,
    required this.parentId,
    required this.levels,
    this.totalStars = 0,
    required this.unlockedAchievements,
    this.dailyPlayTimeLimit = 60,
    required this.lastActive,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: ChildGender.values.byName(json['gender'] as String),
      avatarUrl: json['avatarUrl'] as String?,
      parentId: json['parentId'] as String,
      levels: Map<String, int>.from(json['levels'] as Map),
      totalStars: json['totalStars'] as int? ?? 0,
      unlockedAchievements:
          List<String>.from(json['unlockedAchievements'] as List),
      dailyPlayTimeLimit: json['dailyPlayTimeLimit'] as int? ?? 60,
      lastActive: (json['lastActive'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender.name,
      'avatarUrl': avatarUrl,
      'parentId': parentId,
      'levels': levels,
      'totalStars': totalStars,
      'unlockedAchievements': unlockedAchievements,
      'dailyPlayTimeLimit': dailyPlayTimeLimit,
      'lastActive': Timestamp.fromDate(lastActive),
    };
  }

  ChildProfile copyWith({
    String? id,
    String? name,
    int? age,
    ChildGender? gender,
    String? avatarUrl,
    String? parentId,
    Map<String, int>? levels,
    int? totalStars,
    List<String>? unlockedAchievements,
    int? dailyPlayTimeLimit,
    DateTime? lastActive,
  }) {
    return ChildProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      parentId: parentId ?? this.parentId,
      levels: levels ?? this.levels,
      totalStars: totalStars ?? this.totalStars,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      dailyPlayTimeLimit: dailyPlayTimeLimit ?? this.dailyPlayTimeLimit,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}
