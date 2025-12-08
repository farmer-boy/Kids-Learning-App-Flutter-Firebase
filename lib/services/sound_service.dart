import 'package:audioplayers/audioplayers.dart';
import 'tts_service.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _soundsEnabled = true;

  static void enableSounds(bool enable) {
    _soundsEnabled = enable;
  }

  static Future<void> playLetterSound(String letter) async {
    if (!_soundsEnabled) return;
    
    try {
      await TtsService.speakLetter(letter);
    } catch (e) {
      print('Error playing letter sound: $e');
    }
  }

  static Future<void> playLetterWordSound(String letter) async {
    if (!_soundsEnabled) return;
    
    try {
      await TtsService.speakLetterWord(letter);
    } catch (e) {
      print('Error playing word sound: $e');
    }
  }

  static Future<void> playNumberSound(int number) async {
    if (!_soundsEnabled) return;
    
    try {
      await TtsService.speakNumber(number);
    } catch (e) {
      print('Error playing number sound: $e');
    }
  }

  static Future<void> playColorSound(String color) async {
    if (!_soundsEnabled) return;
    
    try {
      await TtsService.speakColor(color);
    } catch (e) {
      print('Error playing color sound: $e');
    }
  }

  static Future<void> playAnimalSound(String animal) async {
    if (!_soundsEnabled) return;
    
    try {
      await TtsService.speakAnimal(animal);
    } catch (e) {
      print('Error playing animal sound: $e');
    }
  }

  static Future<void> playCorrectSound() async {
    if (!_soundsEnabled) return;
    await TtsService.speakWord('Excellent!');
  }

  static Future<void> playWrongSound() async {
    if (!_soundsEnabled) return;
    await TtsService.speakWord('Try again!');
  }

  static Future<void> playCompletionSound() async {
    if (!_soundsEnabled) return;
    await TtsService.speakSentence('Amazing job! You completed the lesson!');
  }

  static Future<void> playTapSound() async {
    // No sound for tap
  }

  static void dispose() {
    _player.dispose();
    TtsService.stop();
  }
}