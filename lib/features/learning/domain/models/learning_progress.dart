import 'package:cloud_firestore/cloud_firestore.dart';

class LearningProgress {
  final String id;
  final String childId;
  final String contentId;
  final int starsEarned;
  final int timeSpent; // in seconds
  final bool isCompleted;
  final Map<String, dynamic> achievements;
  final DateTime startedAt;
  final DateTime? completedAt;
  final Map<String, dynamic>
      metadata; // Additional progress data specific to content type

  LearningProgress({
    required this.id,
    required this.childId,
    required this.contentId,
    this.starsEarned = 0,
    this.timeSpent = 0,
    this.isCompleted = false,
    required this.achievements,
    required this.startedAt,
    this.completedAt,
    required this.metadata,
  });

  factory LearningProgress.fromJson(Map<String, dynamic> json) {
    return LearningProgress(
      id: json['id'] as String,
      childId: json['childId'] as String,
      contentId: json['contentId'] as String,
      starsEarned: json['starsEarned'] as int? ?? 0,
      timeSpent: json['timeSpent'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      achievements: json['achievements'] as Map<String, dynamic>? ?? {},
      startedAt: (json['startedAt'] as Timestamp).toDate(),
      completedAt: json['completedAt'] != null
          ? (json['completedAt'] as Timestamp).toDate()
          : null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childId': childId,
      'contentId': contentId,
      'starsEarned': starsEarned,
      'timeSpent': timeSpent,
      'isCompleted': isCompleted,
      'achievements': achievements,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt':
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'metadata': metadata,
    };
  }

  LearningProgress copyWith({
    String? id,
    String? childId,
    String? contentId,
    int? starsEarned,
    int? timeSpent,
    bool? isCompleted,
    Map<String, dynamic>? achievements,
    DateTime? startedAt,
    DateTime? completedAt,
    Map<String, dynamic>? metadata,
  }) {
    return LearningProgress(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      contentId: contentId ?? this.contentId,
      starsEarned: starsEarned ?? this.starsEarned,
      timeSpent: timeSpent ?? this.timeSpent,
      isCompleted: isCompleted ?? this.isCompleted,
      achievements: achievements ?? this.achievements,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      metadata: metadata ?? this.metadata,
    );
  }
}
