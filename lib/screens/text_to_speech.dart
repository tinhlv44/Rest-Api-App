import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSExample extends StatefulWidget {
  const TTSExample({super.key});

  @override
  State<TTSExample> createState() => _TTSExampleState();
}

class _TTSExampleState extends State<TTSExample> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();
  bool isSpeaking = false;

  Future<void> _speak() async {
    if (textController.text.isNotEmpty) {
      setState(() => isSpeaking = true);
      await flutterTts.speak(textController.text);
      setState(() => isSpeaking = false);
    }
  }

  Future<void> _stop() async {
    setState(() => isSpeaking = false);
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhập văn bản',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: isSpeaking ? null : _speak,
              icon: const Icon(Icons.volume_up),
              label: const Text('Phát giọng nói'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: isSpeaking ? _stop : null,
              icon: const Icon(Icons.stop),
              label: const Text('Dừng'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
