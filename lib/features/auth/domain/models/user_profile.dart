import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final List<String> childrenIds;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.childrenIds,
    this.isPremium = false,
    required this.createdAt,
    required this.lastLoginAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      childrenIds: List<String>.from(json['childrenIds'] as List),
      isPremium: json['isPremium'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (json['lastLoginAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'childrenIds': childrenIds,
      'isPremium': isPremium,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': Timestamp.fromDate(lastLoginAt),
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    List<String>? childrenIds,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      childrenIds: childrenIds ?? this.childrenIds,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
