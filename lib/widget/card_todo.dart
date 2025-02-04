import 'package:flutter/material.dart';
import 'package:rest_api_app/models/todo.dart';

class CardTodo extends StatefulWidget {
  final VoidCallback? onTap;
  final Todo todo;
  final int index;
  final String heroTag;
  const CardTodo({
    super.key,
    this.onTap,
    required this.todo,
    required this.index,
    required this.heroTag,
  });

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      flightShuttleBuilder:
          (flightContext, animation, direction, fromContext, toContext) {
        return ScaleTransition(
          scale: animation.drive(
            CurveTween(curve: Curves.easeInOut), // Hiệu ứng mượt
          ),
          child: toContext.widget,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width / 2 - 14,
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
