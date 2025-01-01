import 'package:flutter/material.dart';
import 'package:rest_api_app/models/todo.dart';

class CardTodo extends StatefulWidget {
  final VoidCallback? onTap;
  final Todo todo;
  final int index;
  const CardTodo({
    super.key,
    this.onTap,
    required this.todo,
    required this.index,
  });

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Hero(
        tag: 'task_${widget.index}',
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey, // Màu viền
                width: 0.5, // Độ dày viền
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.todo.description!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
