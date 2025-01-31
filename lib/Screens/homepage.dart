import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:med_chatbot/main.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "text":
          "Namaste! 🙏 I am your Ayurveda Assistant. How can I help you today?",
      "isUser": false
    }
  ];
  late GenerativeModel _model;
  late ChatSession _chatSession;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inititalizeGemini();
  }
  void _inititalizeGemini() async {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
          temperature: 0.5, topP: .9, topK: 50, maxOutputTokens: 250),
      systemInstruction: Content.text(
          "You are an Ayurvedic Expert, Answer any Ayurvedic  related Question, such as  herbal Remidies,doshas, diets,yoga,and traditional Medicines And Avoid Non Ayurvedic topics"),
    );
    _chatSession = _model.startChat();
//   Temperature: Controls randomness, higher values increase diversity.

// Top-p (nucleus): The cumulative probability cutoff for token selection. Lower values mean sampling from a smaller, more top-weighted nucleus.

// Top-k: Sample from the k most likely next tokens at each step. Lower k focuses on higher probability tokens.
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.insert(0, {'isUser': true, 'text': _controller.text});
    });
    try {
      final response = await _chatSession
          .sendMessage(Content.text(_controller.text))
          .timeout(Duration(seconds: 20));
      setState(() {
        _messages.insert(0, {'isUser': false, 'text': response.text});
      });
      _controller.clear();
    } catch (e) {
      setState(() {
        _messages.insert(0, {'isUser': false, 'text': "$e"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "AI Ayurveda ChatBot",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[700]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: _messages[index]["text"],
                  isUser: _messages[index]["isUser"],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask about Ayurveda...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green[700]),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[700] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
