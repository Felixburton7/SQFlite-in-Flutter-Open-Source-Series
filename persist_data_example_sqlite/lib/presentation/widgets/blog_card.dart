import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/data/models/blog_model.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final void Function(Blog) onEdit;

  const BlogCard({super.key, required this.blog, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEdit(blog), // Edit blog when tapped.
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${blog.age}, ${blog.name}', // Show Age, Name.
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                blog.post,
                maxLines: 3, // Limit to 3 lines.
                overflow: TextOverflow.ellipsis, // Truncate if too long.
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
