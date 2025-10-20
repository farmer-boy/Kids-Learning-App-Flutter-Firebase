import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class TtsTestScreen extends StatelessWidget {
  const TtsTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TTS Test - Text to Speech'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Text-to-Speech Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This uses device voice (no internet needed)',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            _buildTtsButton('A - Apple', () {
              TtsService.speakLetter('A');
            }),
            
            _buildTtsButton('Number 5', () {
              TtsService.speakNumber(5);
            }),
            
            _buildTtsButton('Color Red', () {
              TtsService.speakColor('Red');
            }),
            
            _buildTtsButton('Animal Cat', () {
              TtsService.speakAnimal('Cat');
            }),
            
            _buildTtsButton('Speak Word', () {
              TtsService.speakWord('Hello!');
            }),
            
            _buildTtsButton('Speak Sentence', () {
              TtsService.speakSentence('You are doing great!');
            }),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                TtsService.stop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Stop Speaking'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTtsButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(text),
      ),
    );
  }
}