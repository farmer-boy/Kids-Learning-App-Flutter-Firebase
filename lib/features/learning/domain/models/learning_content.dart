enum ContentCategory {
  alphabet,
  numbers,
  colors,
  shapes,
  animals,
  stories,
  lifeSkills
}

enum ContentType { lesson, game, quiz, story, song, interactive }

enum ContentDifficulty { beginner, intermediate, advanced }

class LearningContent {
  final String id;
  final String title;
  final String description;
  final ContentCategory category;
  final ContentType type;
  final ContentDifficulty difficulty;
  final int ageRange; // Minimum age recommended
  final int requiredLevel;
  final int starsToEarn;
  final Map<String, String> mediaUrls; // Type -> URL mapping
  final Map<String, dynamic> metadata; // Additional content-specific data
  final bool isPremium;
  final bool isActive;
  final int completionCount;

  LearningContent({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.difficulty,
    required this.ageRange,
    required this.requiredLevel,
    required this.starsToEarn,
    required this.mediaUrls,
    required this.metadata,
    this.isPremium = false,
    this.isActive = true,
    this.completionCount = 0,
  });

  factory LearningContent.fromJson(Map<String, dynamic> json) {
    return LearningContent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: ContentCategory.values.byName(json['category'] as String),
      type: ContentType.values.byName(json['type'] as String),
      difficulty: ContentDifficulty.values.byName(json['difficulty'] as String),
      ageRange: json['ageRange'] as int,
      requiredLevel: json['requiredLevel'] as int,
      starsToEarn: json['starsToEarn'] as int,
      mediaUrls: Map<String, String>.from(json['mediaUrls'] as Map),
      metadata: json['metadata'] as Map<String, dynamic>,
      isPremium: json['isPremium'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      completionCount: json['completionCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category.name,
      'type': type.name,
      'difficulty': difficulty.name,
      'ageRange': ageRange,
      'requiredLevel': requiredLevel,
      'starsToEarn': starsToEarn,
      'mediaUrls': mediaUrls,
      'metadata': metadata,
      'isPremium': isPremium,
      'isActive': isActive,
      'completionCount': completionCount,
    };
  }

  LearningContent copyWith({
    String? id,
    String? title,
    String? description,
    ContentCategory? category,
    ContentType? type,
    ContentDifficulty? difficulty,
    int? ageRange,
    int? requiredLevel,
    int? starsToEarn,
    Map<String, String>? mediaUrls,
    Map<String, dynamic>? metadata,
    bool? isPremium,
    bool? isActive,
    int? completionCount,
  }) {
    return LearningContent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      ageRange: ageRange ?? this.ageRange,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      starsToEarn: starsToEarn ?? this.starsToEarn,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      metadata: metadata ?? this.metadata,
      isPremium: isPremium ?? this.isPremium,
      isActive: isActive ?? this.isActive,
      completionCount: completionCount ?? this.completionCount,
    );
  }
}
