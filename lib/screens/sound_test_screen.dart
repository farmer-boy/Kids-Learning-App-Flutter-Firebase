import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class SoundTestScreen extends StatelessWidget {
  const SoundTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Test Sounds',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            _buildSoundButton('Play Letter Sound', () {
              SoundService.playLetterSound('A');
            }),
            
            _buildSoundButton('Play Word Sound', () {
              SoundService.playLetterWordSound('A');
            }),
            
            _buildSoundButton('Play Number Sound', () {
              SoundService.playNumberSound(1);
            }),
            
            _buildSoundButton('Play Count Sound', () {
              SoundService.playCountSound(3);
            }),
            
            _buildSoundButton('Play Color Sound', () {
              SoundService.playColorSound('red');
            }),
            
            _buildSoundButton('Play Animal Sound', () {
              SoundService.playAnimalSound('cat');
            }),
            
            _buildSoundButton('Play Correct Sound', () {
              SoundService.playCorrectSound();
            }),
            
            _buildSoundButton('Play Wrong Sound', () {
              SoundService.playWrongSound();
            }),
            
            _buildSoundButton('Play Completion Sound', () {
              SoundService.playCompletionSound();
            }),
            
            _buildSoundButton('Play Tap Sound', () {
              SoundService.playTapSound();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(text),
      ),
    );
  }
}