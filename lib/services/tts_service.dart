import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.setPitch(1.3);
      await _flutterTts.setVolume(1.0);
      _isInitialized = true;
    } catch (e) {
      print("Error initializing TTS: $e");
    }
  }

  static Future<void> speakLetter(String letter) async {
    await initialize();
    try {
      await _flutterTts.speak('The letter $letter');
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print("Error speaking letter: $e");
    }
  }

  static Future<void> speakLetterWord(String letter) async {
    await initialize();
    try {
      String word = _getCorrectWordForLetter(letter);
      await _flutterTts.speak('$letter for $word');
    } catch (e) {
      print("Error speaking letter word: $e");
    }
  }

  static Future<void> speakNumber(int number) async {
    await initialize();
    try {
      await _flutterTts.speak('Number $number');
    } catch (e) {
      print("Error speaking number: $e");
    }
  }

  static Future<void> speakColor(String color) async {
    await initialize();
    try {
      await _flutterTts.speak('Color $color');
    } catch (e) {
      print("Error speaking color: $e");
    }
  }

  static Future<void> speakAnimal(String animal) async {
    await initialize();
    try {
      await _flutterTts.speak(animal);
    } catch (e) {
      print("Error speaking animal: $e");
    }
  }

  static Future<void> speakWord(String word) async {
    await initialize();
    try {
      await _flutterTts.speak(word);
    } catch (e) {
      print("Error speaking word: $e");
    }
  }

  static Future<void> speakSentence(String sentence) async {
    await initialize();
    try {
      await _flutterTts.speak(sentence);
    } catch (e) {
      print("Error speaking sentence: $e");
    }
  }

  static String _getCorrectWordForLetter(String letter) {
    final words = {
      'A': 'Apple', 'B': 'Ball', 'C': 'Cat', 'D': 'Dog',
      'E': 'Elephant', 'F': 'Fish', 'G': 'Grapes', 'H': 'House'
    };
    return words[letter] ?? 'thing';
  }

  static void stop() {
    _flutterTts.stop();
  }
}