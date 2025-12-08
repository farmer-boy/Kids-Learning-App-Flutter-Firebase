import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class LessonScreen extends StatefulWidget {
  final String category;
  final int lessonNumber;
  final String lessonTitle;
  final Color categoryColor;

  const LessonScreen({
    super.key,
    required this.category,
    required this.lessonNumber,
    required this.lessonTitle,
    required this.categoryColor,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Color?> _colorAnimation;
  int _currentStep = 0;
  int _score = 0;
  bool _showCompletion = false;
  bool _isPlayingSound = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _colorAnimation = ColorTween(
      begin: widget.categoryColor.withOpacity(0.5),
      end: widget.categoryColor,
    ).animate(_controller);
    
    _controller.forward();
    _playWelcomeSound();
  }

  void _playWelcomeSound() async {
    await Future.delayed(const Duration(milliseconds: 800));
    switch (widget.category) {
      case 'Alphabet':
        await SoundService.playLetterSound(_getCurrentLetter());
        break;
      case 'Numbers':
        await SoundService.playNumberSound(widget.lessonNumber);
        break;
      case 'Colors':
        await SoundService.playColorSound(_getCurrentColor());
        break;
      case 'Animals':
        await SoundService.playAnimalSound(_getCurrentAnimal());
        break;
    }
  }

  String _getCurrentLetter() {
    final letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    return letters[widget.lessonNumber - 1];
  }

  String _getCurrentColor() {
    final colors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];
    return colors[widget.lessonNumber - 1];
  }

  String _getCurrentAnimal() {
    final animals = ['Cat', 'Bear', 'Dolphin', 'Elephant', 'Frog', 'Giraffe'];
    return animals[widget.lessonNumber - 1];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < _getTotalSteps() - 1) {
        _currentStep++;
        _controller.reset();
        _controller.forward();
        _playStepSound();
      } else {
        _showCompletion = true;
        _score += 10;
        SoundService.playCompletionSound();
      }
    });
  }

  void _playStepSound() async {
    if (_isPlayingSound) return;
    _isPlayingSound = true;

    try {
      switch (widget.category) {
        case 'Alphabet':
          if (_currentStep == 0) {
            await SoundService.playLetterSound(_getCurrentLetter());
          } else if (_currentStep == 2) {
            await Future.delayed(const Duration(milliseconds: 500));
            await SoundService.playLetterWordSound(_getCurrentLetter());
          }
          break;
        case 'Numbers':
          if (_currentStep == 0) {
            await SoundService.playNumberSound(widget.lessonNumber);
          }
          break;
        case 'Colors':
          if (_currentStep == 0) {
            await SoundService.playColorSound(_getCurrentColor());
          }
          break;
        case 'Animals':
          if (_currentStep == 0) {
            await SoundService.playAnimalSound(_getCurrentAnimal());
          }
          break;
      }
    } catch (e) {
      print('Error playing step sound: $e');
    } finally {
      _isPlayingSound = false;
    }
  }

  void _correctAnswer() {
    SoundService.playCorrectSound();
    setState(() {
      _score += 5;
    });
    _nextStep();
  }

  void _wrongAnswer() {
    SoundService.playWrongSound();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lightbulb, color: Colors.amber, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('Try again! You can do it!'),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  int _getTotalSteps() => 4;

  Widget _buildAlphabetStep() {
    final letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    final words = ['Apple', 'Ball', 'Cat', 'Dog', 'Elephant', 'Fish', 'Grapes', 'House'];
    final emojis = ['🍎', '🏀', '🐱', '🐶', '🐘', '🐠', '🍇', '🏠'];
    
    switch (_currentStep) {
      case 0:
        return _buildPremiumAnimationStep(
          'Let\'s Learn Letter ${letters[widget.lessonNumber - 1]}!',
          'The letter ${letters[widget.lessonNumber - 1]} makes the "${letters[widget.lessonNumber - 1].toLowerCase()}" sound',
          Icons.abc,
          ['${letters[widget.lessonNumber - 1]}', '${letters[widget.lessonNumber - 1].toLowerCase()}'],
          emoji: emojis[widget.lessonNumber - 1],
          onPlaySound: () async {
            await SoundService.playLetterSound(letters[widget.lessonNumber - 1]);
          },
        );
      case 1:
        return _buildPremiumInteractiveStep(
          'Find Letter ${letters[widget.lessonNumber - 1]}',
          'Tap the correct letter below',
          ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
          letters[widget.lessonNumber - 1],
        );
      case 2:
        return _buildPremiumImageStep(
          '${letters[widget.lessonNumber - 1]} is for ${words[widget.lessonNumber - 1]}',
          emojis[widget.lessonNumber - 1],
          '${letters[widget.lessonNumber - 1]}... ${words[widget.lessonNumber - 1]}!',
          onPlaySound: () async {
            await SoundService.playLetterSound(letters[widget.lessonNumber - 1]);
            await Future.delayed(const Duration(milliseconds: 800));
            await SoundService.playLetterWordSound(letters[widget.lessonNumber - 1]);
          },
        );
      case 3:
        return _buildPremiumQuizStep(
          'Quick Quiz!',
          'What letter comes after ${letters[widget.lessonNumber - 1]}?',
          [
            letters[widget.lessonNumber % letters.length],
            letters[(widget.lessonNumber + 2) % letters.length],
            letters[(widget.lessonNumber + 4) % letters.length],
          ],
          0,
        );
      default:
        return Container();
    }
  }

  Widget _buildNumbersStep() {
    final numbers = [5, 10, 15, 20, 25, 30];
    final emojis = ['🔢', '🎯', '⭐', '🏆', '👑', '💎'];
    
    switch (_currentStep) {
      case 0:
        return _buildPremiumAnimationStep(
          'Let\'s Count to ${numbers[widget.lessonNumber - 1]}!',
          'Numbers help us count everything around us',
          Icons.numbers,
          List.generate(5, (i) => '${i + 1}'),
          emoji: emojis[widget.lessonNumber - 1],
          onPlaySound: () async {
            await SoundService.playNumberSound(widget.lessonNumber);
          },
        );
      case 1:
        return _buildPremiumInteractiveStep(
          'How Many Objects?',
          'Count the objects and select the correct number',
          ['${numbers[widget.lessonNumber - 1] - 2}', '${numbers[widget.lessonNumber - 1]}', '${numbers[widget.lessonNumber - 1] + 2}'],
          '${numbers[widget.lessonNumber - 1]}',
        );
      case 2:
        return _buildPremiumImageStep(
          'Number ${numbers[widget.lessonNumber - 1]}',
          '🎉',
          'Great job! ${numbers[widget.lessonNumber - 1]} is an important number!',
          onPlaySound: () => SoundService.playNumberSound(widget.lessonNumber),
        );
      case 3:
        return _buildPremiumQuizStep(
          'Number Challenge!',
          'What is ${numbers[widget.lessonNumber - 1] ~/ 2} + ${numbers[widget.lessonNumber - 1] ~/ 2}?',
          [
            '${numbers[widget.lessonNumber - 1]}',
            '${numbers[widget.lessonNumber - 1] + 5}',
            '${numbers[widget.lessonNumber - 1] - 5}',
          ],
          0,
        );
      default:
        return Container();
    }
  }

  Widget _buildColorsStep() {
    final colors = [
      {'name': 'Red', 'emoji': '🔴', 'object': 'Apple'},
      {'name': 'Blue', 'emoji': '🔵', 'object': 'Sky'},
      {'name': 'Green', 'emoji': '🟢', 'object': 'Leaf'},
      {'name': 'Yellow', 'emoji': '🟡', 'object': 'Sun'},
      {'name': 'Purple', 'emoji': '🟣', 'object': 'Grape'},
      {'name': 'Orange', 'emoji': '🟠', 'object': 'Orange'},
    ];
    
    switch (_currentStep) {
      case 0:
        return _buildPremiumAnimationStep(
          'Discover ${colors[widget.lessonNumber - 1]['name']}!',
          '${colors[widget.lessonNumber - 1]['emoji']} ${colors[widget.lessonNumber - 1]['name']} is a beautiful color!',
          Icons.palette,
          [colors[widget.lessonNumber - 1]['name'] as String, colors[widget.lessonNumber - 1]['emoji'] as String],
          emoji: colors[widget.lessonNumber - 1]['emoji'] as String,
          onPlaySound: () => SoundService.playColorSound(colors[widget.lessonNumber - 1]['name'] as String),
        );
      case 1:
        return _buildPremiumInteractiveStep(
          'Find ${colors[widget.lessonNumber - 1]['name']}',
          'Tap the ${colors[widget.lessonNumber - 1]['name']} colored object',
          ['Red Ball', 'Blue Car', '${colors[widget.lessonNumber - 1]['name']} ${colors[widget.lessonNumber - 1]['object']}', 'Green Tree'],
          '${colors[widget.lessonNumber - 1]['name']} ${colors[widget.lessonNumber - 1]['object']}',
        );
      case 2:
        return _buildColorMixingStep(colors[widget.lessonNumber - 1]);
      case 3:
        return _buildPremiumQuizStep(
          'Color Quiz!',
          'What color do you get when you mix Red and Blue?',
          ['Purple', 'Green', 'Orange'],
          0,
        );
      default:
        return Container();
    }
  }

  Widget _buildColorMixingStep(Map<String, dynamic> color) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Color Mixing Magic! 🎨',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: widget.categoryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorCircle(Colors.red, 'Red'),
                      const SizedBox(width: 20),
                      const Icon(Icons.add, size: 30, color: Colors.grey),
                      const SizedBox(width: 20),
                      _buildColorCircle(Colors.blue, 'Blue'),
                      const SizedBox(width: 20),
                      const Icon(Icons.arrow_forward, size: 30, color: Colors.grey),
                      const SizedBox(width: 20),
                      _buildColorCircle(Color(0xFF800080), color['name'] as String),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Red + Blue = ${color['name']}!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    color['emoji'] as String,
                    style: const TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => SoundService.playColorSound(color['name'] as String),
              icon: const Icon(Icons.volume_up_rounded),
              label: const Text(
                'Hear Color Name',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.categoryColor,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                minimumSize: const Size(200, 50),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumAnimationStep(String title, String description, IconData icon, List<String> elements, {String? emoji, VoidCallback? onPlaySound}) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (emoji != null) ...[
              Text(
                emoji,
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
            ],
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.categoryColor, widget.categoryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.categoryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(icon, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: elements.map((element) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: widget.categoryColor.withOpacity(0.3)),
                ),
                child: Text(
                  element,
                  style: TextStyle(
                    color: widget.categoryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 30),
            if (onPlaySound != null)
              ElevatedButton.icon(
                onPressed: onPlaySound,
                icon: const Icon(Icons.volume_up_rounded),
                label: const Text(
                  'Hear Sound',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.categoryColor,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(200, 50),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildPremiumInteractiveStep(String title, String instruction, List<String> options, String correctAnswer) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.categoryColor.withOpacity(0.1), widget.categoryColor.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    instruction,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ...options.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    if (entry.value == correctAnswer) {
                      _correctAnswer();
                    } else {
                      _wrongAnswer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2D3748),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: widget.categoryColor.withOpacity(0.3)),
                    ),
                    minimumSize: const Size(250, 55),
                  ),
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumImageStep(String title, String emoji, String description, {VoidCallback? onPlaySound}) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.categoryColor.withOpacity(0.1), widget.categoryColor.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 100),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (onPlaySound != null)
              ElevatedButton.icon(
                onPressed: onPlaySound,
                icon: const Icon(Icons.volume_up_rounded),
                label: const Text(
                  'Hear Pronunciation',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.categoryColor,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(250, 50),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumQuizStep(String title, String question, List<String> options, int correctIndex) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.categoryColor.withOpacity(0.1), widget.categoryColor.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.categoryColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    question,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2D3748),
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ...options.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    if (entry.key == correctIndex) {
                      _correctAnswer();
                    } else {
                      _wrongAnswer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2D3748),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: widget.categoryColor.withOpacity(0.3)),
                    ),
                    minimumSize: const Size(280, 60),
                  ),
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD166), Color(0xFFFFB347)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 25,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.celebration,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              '🎉 Amazing Work! 🎉',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.categoryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'You completed ${widget.lessonTitle}!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.categoryColor.withOpacity(0.1), widget.categoryColor.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Total Score',
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.categoryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_score Points',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.grey.shade700,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(140, 55),
                  ),
                  child: const Text(
                    'More Lessons',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showCompletion = false;
                      _currentStep = 0;
                      _score = 0;
                      _controller.reset();
                      _controller.forward();
                      _playWelcomeSound();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.categoryColor,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(140, 55),
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    if (_showCompletion) {
      return _buildCompletionScreen();
    }

    switch (widget.category) {
      case 'Alphabet':
        return _buildAlphabetStep();
      case 'Numbers':
        return _buildNumbersStep();
      case 'Colors':
        return _buildColorsStep();
      case 'Shapes':
        return _buildPremiumAnimationStep(
          'Learning Shapes!',
          'Let\'s explore different shapes and patterns',
          Icons.crop_square,
          ['Circle', 'Square', 'Triangle', 'Rectangle'],
          emoji: '⭐',
          onPlaySound: () => SoundService.playCorrectSound(),
        );
      case 'Animals':
        return _buildPremiumAnimationStep(
          'Animal Friends!',
          'Meet amazing animals from around the world',
          Icons.pets,
          ['🐘 Elephant', '🦒 Giraffe', '🐬 Dolphin', '🐻 Bear'],
          emoji: '🐾',
          onPlaySound: () => SoundService.playAnimalSound(_getCurrentAnimal()),
        );
      case 'Stories':
        return _buildPremiumAnimationStep(
          'Story Time!',
          'Listen to an exciting story with moral lessons',
          Icons.menu_book,
          ['Once upon a time...', 'The End'],
          emoji: '📚',
          onPlaySound: () => SoundService.playCorrectSound(),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          '${widget.category} - ${widget.lessonTitle}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: widget.categoryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 6),
                Text(
                  '$_score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up_rounded, color: Colors.white),
            onPressed: () {
              _playStepSound();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Animated Progress Bar
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: (_currentStep + 1) / _getTotalSteps(),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(_colorAnimation.value ?? widget.categoryColor),
                  ),
                ),
              );
            },
          ),
          
          // Step Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_getTotalSteps(), (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: index <= _currentStep ? widget.categoryColor : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    boxShadow: index <= _currentStep ? [
                      BoxShadow(
                        color: widget.categoryColor.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ] : null,
                  ),
                  child: Icon(
                    index < _currentStep ? Icons.check : Icons.circle,
                    color: Colors.white,
                    size: 16,
                  ),
                );
              }),
            ),
          ),
          
          // Current Step Content
          Expanded(
            child: _buildCurrentStep(),
          ),
          
          // Navigation Buttons
          if (!_showCompletion)
            Container(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.categoryColor,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: Text(
                  _currentStep == _getTotalSteps() - 1 ? 'Complete Lesson 🎉' : 'Continue Learning →',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}