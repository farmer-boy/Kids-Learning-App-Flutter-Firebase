import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header with Glass Morphism
          SliverAppBar(
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFD166), Color(0xFFFFB347)],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background Elements
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      bottom: -20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    
                    // Content
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            size: 80,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'My Achievements',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ComicNeue',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Keep learning to earn more rewards!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Stats and Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // Stats Cards
                  _buildStatsRow(),
                  const SizedBox(height: 30),
                  
                  // Badges Section
                  _buildSectionHeader('Badges & Awards', Icons.workspace_premium_rounded),
                  const SizedBox(height: 20),
                  _buildBadgesGrid(),
                  const SizedBox(height: 30),
                  
                  // Progress Section
                  _buildSectionHeader('Learning Progress', Icons.timeline_rounded),
                  const SizedBox(height: 20),
                  _buildProgressList(),
                  const SizedBox(height: 30),
                  
                  // Recent Achievements
                  _buildSectionHeader('Recent Achievements', Icons.new_releases_rounded),
                  const SizedBox(height: 20),
                  _buildRecentAchievements(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            '15',
            'Lessons\nCompleted',
            Icons.school_rounded,
            const Color(0xFF667EEA),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            '250',
            'Total\nPoints',
            Icons.star_rounded,
            const Color(0xFFFF6B6B),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            '8',
            'Badges\nEarned',
            Icons.workspace_premium_rounded,
            const Color(0xFF4ECDC4),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF667EEA),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesGrid() {
    final badges = [
      {
        'name': 'Alphabet Master',
        'icon': Icons.abc_rounded,
        'earned': true,
        'color': const Color(0xFFFFD166),
        'description': 'Complete all alphabet lessons'
      },
      {
        'name': 'Number Whiz',
        'icon': Icons.numbers_rounded,
        'earned': true,
        'color': const Color(0xFF4ECDC4),
        'description': 'Master number counting'
      },
      {
        'name': 'Color Expert',
        'icon': Icons.palette_rounded,
        'earned': true,
        'color': const Color(0xFFFF6B6B),
        'description': 'Learn all colors'
      },
      {
        'name': 'Shape Explorer',
        'icon': Icons.crop_square_rounded,
        'earned': false,
        'color': const Color(0xFF6A93C6),
        'description': 'Discover all shapes'
      },
      {
        'name': 'Animal Lover',
        'icon': Icons.pets_rounded,
        'earned': true,
        'color': const Color(0xFF9B5DE5),
        'description': 'Meet all animals'
      },
      {
        'name': 'Story Teller',
        'icon': Icons.menu_book_rounded,
        'earned': false,
        'color': const Color(0xFFF15BB5),
        'description': 'Read all stories'
      },
      {
        'name': 'Perfect Score',
        'icon': Icons.celebration_rounded,
        'earned': false,
        'color': const Color(0xFFFFA500),
        'description': 'Get 100% in all quizzes'
      },
      {
        'name': 'Daily Learner',
        'icon': Icons.today_rounded,
        'earned': true,
        'color': const Color(0xFF00CED1),
        'description': 'Learn for 7 days straight'
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
        return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: badge['earned'] as bool 
                    ? LinearGradient(
                        colors: [badge['color'] as Color, (badge['color'] as Color).withOpacity(0.8)],
                      )
                    : null,
                color: badge['earned'] as bool ? null : Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: badge['earned'] as bool ? [
                  BoxShadow(
                    color: (badge['color'] as Color).withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ] : null,
                border: Border.all(
                  color: badge['earned'] as bool ? badge['color'] as Color : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: badge['earned'] as bool
                  ? Icon(badge['icon'] as IconData, color: Colors.white, size: 30)
                  : const Icon(Icons.lock_rounded, color: Colors.grey, size: 25),
            ),
            const SizedBox(height: 8),
            Text(
              badge['name'] as String,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: badge['earned'] as bool ? const Color(0xFF2D3748) : Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressList() {
    final categories = [
      {'name': 'Alphabet', 'progress': 0.8, 'lessons': '10/12', 'color': const Color(0xFFFFD166), 'icon': Icons.abc_rounded},
      {'name': 'Numbers', 'progress': 0.6, 'lessons': '6/8', 'color': const Color(0xFF4ECDC4), 'icon': Icons.numbers_rounded},
      {'name': 'Colors', 'progress': 0.9, 'lessons': '5/6', 'color': const Color(0xFFFF6B6B), 'icon': Icons.palette_rounded},
      {'name': 'Shapes', 'progress': 0.4, 'lessons': '2/5', 'color': const Color(0xFF6A93C6), 'icon': Icons.crop_square_rounded},
      {'name': 'Animals', 'progress': 0.7, 'lessons': '10/15', 'color': const Color(0xFF9B5DE5), 'icon': Icons.pets_rounded},
      {'name': 'Stories', 'progress': 0.5, 'lessons': '5/10', 'color': const Color(0xFFF15BB5), 'icon': Icons.menu_book_rounded},
    ];

    return Column(
      children: categories.map((category) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [category['color'] as Color, (category['color'] as Color).withOpacity(0.8)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(category['icon'] as IconData, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: category['progress'] as double,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(category['color'] as Color),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: category['color'] as Color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  category['lessons'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentAchievements() {
    final achievements = [
      {'title': 'Alphabet Master', 'description': 'Completed all A-Z lessons', 'time': '2 hours ago', 'icon': Icons.abc_rounded, 'color': const Color(0xFFFFD166)},
      {'title': 'Perfect Quiz', 'description': 'Scored 100% in Colors quiz', 'time': '1 day ago', 'icon': Icons.quiz_rounded, 'color': const Color(0xFFFF6B6B)},
      {'title': 'Daily Streak', 'description': '7 days of learning', 'time': '2 days ago', 'icon': Icons.local_fire_department_rounded, 'color': const Color(0xFFFFA500)},
      {'title': 'Fast Learner', 'description': 'Completed 5 lessons in one day', 'time': '3 days ago', 'icon': Icons.bolt_rounded, 'color': const Color(0xFF9B5DE5)},
    ];

    return Column(
      children: achievements.map((achievement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [achievement['color'] as Color, (achievement['color'] as Color).withOpacity(0.8)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(achievement['icon'] as IconData, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement['description'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement['time'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (achievement['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.celebration_rounded, color: Colors.amber, size: 20),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}