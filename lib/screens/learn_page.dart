import 'package:flutter/material.dart';
import 'category_content_screen.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  void _openCategory(BuildContext context, Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryContentScreen(
          categoryName: category['title'],
          lessonCount: category['lessonCount'],
          categoryColor: category['color'],
          categoryIcon: category['icon'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Alphabet',
        'icon': Icons.abc,
        'color': const Color(0xFFFFD166),
        'lessonCount': 12,
        'progress': 0.6
      },
      {
        'title': 'Numbers',
        'icon': Icons.numbers,
        'color': const Color(0xFF06D6A0),
        'lessonCount': 8,
        'progress': 0.3
      },
      {
        'title': 'Colors',
        'icon': Icons.palette,
        'color': const Color(0xFFEF476F),
        'lessonCount': 6,
        'progress': 0.8
      },
      {
        'title': 'Shapes',
        'icon': Icons.crop_square,
        'color': const Color(0xFF118AB2),
        'lessonCount': 5,
        'progress': 0.4
      },
      {
        'title': 'Animals',
        'icon': Icons.pets,
        'color': const Color(0xFF9B5DE5),
        'lessonCount': 15,
        'progress': 0.2
      },
      {
        'title': 'Stories',
        'icon': Icons.menu_book,
        'color': const Color(0xFFF15BB5),
        'lessonCount': 10,
        'progress': 0.9
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Learning Center',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF4A6FA5),
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A6FA5), Color(0xFF6A93C6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = categories[index];
                return _buildCategoryCard(context, category);
              },
              childCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category['color'] as Color, category['color'].withOpacity(0.8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => _openCategory(context, category),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${category['lessonCount']} Lessons',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: category['progress'] as double,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}