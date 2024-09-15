import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/data/models/blog_model.dart';
import 'package:persist_data_example_sqlite/presentation/widgets/blog_card.dart'; // Import your BlogCard widget

class BlogList extends StatelessWidget {
  final bool showAllBlogs;
  final List<Blog> blogs; // The list of blogs to display
  final Function(int)
      deleteBlog; // Callback Function to delete blog with specific int;
  final Function(Blog)
      editBlog; // Callback to edit a blog, passing the Blog object

  const BlogList({
    super.key,
    required this.showAllBlogs,
    required this.blogs,
    required this.deleteBlog,
    required this.editBlog,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: showAllBlogs
          ? ListView.builder(
              itemCount: blogs.length, // Number of blogs to display
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey<int>(
                      blogs[index].id!), // Unique key for each blog
                  direction:
                      DismissDirection.endToStart, // Swipe left to delete
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red, // Red background when swiping to delete
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete,
                        color: Colors.white), // Trash icon
                  ),
                  onDismissed: (direction) {
                    deleteBlog(blogs[index]
                        .id!); // Call the delete callback when dismissed
                  },
                  child: SizedBox(
                    width: double.infinity, // Ensure the card takes full width
                    child: BlogCard(
                      blog: blogs[index],
                      onEdit: editBlog, // Pass the edit callback
                    ),
                  ),
                );
              },
            )
          : blogs.isNotEmpty
              ? SingleChildScrollView(
                  child: SizedBox(
                      width:
                          double.infinity, // Ensure the card takes full width
                      child: BlogCard(
                          blog: blogs.last, // Show the last inserted blog
                          onEdit: editBlog)), // Pass the edit callback
                )
              : const Center(
                  child: Text(
                    'No recent blog available',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }
}
