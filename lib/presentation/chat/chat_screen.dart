import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_nutrition/presentation/chat/chat_provider.dart';
import 'package:food_nutrition/data/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().connect();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${provider.error}'),
                        ElevatedButton(
                          onPressed: () => provider.connect(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    return _SimpleMessageItem(message: message);
                  },
                );
              },
            ),
          ),
          _SimpleMessageInput(
            controller: _messageController,
            onSend: (content, asAdmin) {
              context.read<ChatProvider>().sendMessage(content, asAdmin: asAdmin);
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _SimpleMessageItem extends StatelessWidget {
  final ChatMessage message;

  const _SimpleMessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    final isAdmin = message.sender.isAdmin;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isAdmin ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '${message.sender.name}:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.content),
            Text(
              _formatTime(message.timestamp),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class _SimpleMessageInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String content, bool asAdmin) onSend;

  const _SimpleMessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  State<_SimpleMessageInput> createState() => _SimpleMessageInputState();
}

class _SimpleMessageInputState extends State<_SimpleMessageInput> {
  bool _sendAsAdmin = false;

  void _handleSend() {
    final content = widget.controller.text.trim();
    if (content.isNotEmpty) {
      widget.onSend(content, _sendAsAdmin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _sendAsAdmin,
                onChanged: (value) {
                  setState(() {
                    _sendAsAdmin = value ?? false;
                  });
                },
              ),
              const Text('Send as Admin'),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _handleSend,
                child: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}