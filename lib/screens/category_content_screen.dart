import 'package:flutter/material.dart';
import 'lesson_screen.dart';

class CategoryContentScreen extends StatelessWidget {
  final String categoryName;
  final int lessonCount;
  final Color categoryColor;
  final IconData categoryIcon;

  const CategoryContentScreen({
    super.key,
    required this.categoryName,
    required this.lessonCount,
    required this.categoryColor,
    required this.categoryIcon,
  });

  void _startLesson(BuildContext context, int lessonNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          category: categoryName,
          lessonNumber: lessonNumber,
          lessonTitle: _getLessonTitle(lessonNumber),
          categoryColor: categoryColor,
        ),
      ),
    );
  }

  String _getLessonTitle(int lessonNumber) {
    switch (categoryName) {
      case 'Alphabet':
        return 'Letter ${String.fromCharCode(64 + lessonNumber)}';
      case 'Numbers':
        return 'Counting to ${lessonNumber * 5}';
      case 'Colors':
        final colors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];
        return colors[lessonNumber - 1];
      case 'Shapes':
        final shapes = ['Circle', 'Square', 'Triangle', 'Rectangle', 'Star'];
        return shapes[lessonNumber - 1];
      case 'Animals':
        final animals = ['Farm Animals', 'Jungle Animals', 'Sea Animals', 'Birds', 'Insects'];
        return animals[(lessonNumber - 1) % 5];
      case 'Stories':
        final stories = ['The Little Seed', 'Colorful Rainbow', 'Animal Friends', 'Number Adventure'];
        return stories[(lessonNumber - 1) % 4];
      default:
        return 'Fun Learning';
    }
  }

  String _getLessonDescription(int lessonNumber) {
    switch (categoryName) {
      case 'Alphabet':
        return 'Learn letter ${String.fromCharCode(64 + lessonNumber)} with fun examples';
      case 'Numbers':
        return 'Practice counting and number recognition';
      case 'Colors':
        return 'Discover and identify different colors';
      case 'Shapes':
        return 'Learn about basic shapes and patterns';
      case 'Animals':
        return 'Meet amazing animals and their habitats';
      case 'Stories':
        return 'Interactive story with moral lessons';
      default:
        return 'Engaging educational content';
    }
  }

  Widget _buildLessonItem(BuildContext context, int lessonNumber) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: categoryColor.withOpacity(0.2),
          child: Text(
            '$lessonNumber',
            style: TextStyle(
              color: categoryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          'Lesson $lessonNumber: ${_getLessonTitle(lessonNumber)}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(_getLessonDescription(lessonNumber)),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.green, size: 30),
        onTap: () {
          _startLesson(context, lessonNumber);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: categoryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [categoryColor, categoryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(categoryIcon, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    '$lessonCount Lessons',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _getCategoryDescription(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LinearProgressIndicator(
              value: 0.6, // Example progress - you can make this dynamic
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
          // Lessons List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lessons',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
                Text(
                  'Completed: ${(lessonCount * 0.6).toInt()}/$lessonCount',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Lessons List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: lessonCount,
              itemBuilder: (context, index) {
                return _buildLessonItem(context, index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryDescription() {
    switch (categoryName) {
      case 'Alphabet':
        return 'Learn A to Z with fun animations and sounds';
      case 'Numbers':
        return 'Master counting and basic math skills';
      case 'Colors':
        return 'Discover the wonderful world of colors';
      case 'Shapes':
        return 'Explore geometric shapes and patterns';
      case 'Animals':
        return 'Meet amazing creatures from around the world';
      case 'Stories':
        return 'Enjoy interactive stories with valuable lessons';
      default:
        return 'Fun and engaging learning activities';
    }
  }
}