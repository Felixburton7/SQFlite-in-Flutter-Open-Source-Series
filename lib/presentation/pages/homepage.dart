import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/core/theme_extensions.dart'; // Theme extensions for Spotify theme.
import 'package:persist_data_example_sqlite/data/datasources/datasource.dart'; // Data source for SQLite database operations.
import 'package:persist_data_example_sqlite/data/models/blog_model.dart'; // Blog model representing the blog object.
import 'package:persist_data_example_sqlite/presentation/pages/navdrawer.dart';
import 'package:persist_data_example_sqlite/presentation/widgets/blog_card.dart'; // Widget to display each blog post in a card.

class MyHomePage extends StatefulWidget {
  final String title; // Title for the page.
  final bool isDarkMode; // Flag to check if the dark mode is enabled.
  final Function(bool) onThemeChanged; // Function to change the theme.

  const MyHomePage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _authorNameController =
      TextEditingController(); // Controller for author name input.
  final TextEditingController _authorAgeController =
      TextEditingController(); // Controller for author age input.
  final TextEditingController _blogPostController =
      TextEditingController(); // Controller for blog post content.

  final Datasource datasource =
      Datasource(); // Instance of the Datasource for interacting with the database.
  List<Blog> _blogs = []; // List of blogs fetched from the database.
  Blog? _lastInsertedBlog; // Stores the last inserted blog.
  Blog? _editingBlog; // Stores the blog currently being edited.

  bool _showAllBlogs =
      false; // Flag to toggle between all blogs and recent blog.
  bool _showTextFields =
      false; // Flag to toggle the visibility of text fields (new post form).
  bool _blogInserted = false; // Track if a blog has been inserted.

  late AnimationController
      _animationController; // Controller for animating form appearance.
  late Animation<double>
      _textFieldOpacity; // Animation for fading the text fields.

  @override
  void initState() {
    super.initState();
    _fetchBlogs(); // Fetch blogs from the database on initialization.

    // Initialize the animation controller for form appearance.
    _animationController = AnimationController(
      vsync: this, // Synchronizes the animation with this widget.
      duration:
          const Duration(milliseconds: 500), // Duration for the animation.
    );

    // Tween for controlling opacity of the text fields (fade-in, fade-out).
    _textFieldOpacity =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  // Function to either insert a new blog or update an existing one.
  Future<void> _saveBlog() async {
    String authorName =
        _authorNameController.text; // Get the author name from the input field.
    int authorAge = int.parse(_authorAgeController.text); // Get the author age.
    String blogPost = _blogPostController.text; // Get the blog content.

    if (_editingBlog != null) {
      // Update the existing blog
      Blog updatedBlog = Blog(
        id: _editingBlog!.id, // Use the ID of the blog being edited.
        name: authorName,
        age: authorAge,
        post: blogPost,
      );
      await datasource
          .updateBlog(updatedBlog); // Update the blog in the database.
    } else {
      // Insert a new blog
      Blog newBlog = Blog(name: authorName, age: authorAge, post: blogPost);
      await datasource
          .insertBlog(newBlog); // Insert the blog into the database.
      _lastInsertedBlog = newBlog; // Set the last inserted blog.
    }

    _clearForm(); // Clear the form after saving.
    _fetchBlogs(); // Fetch updated list of blogs.
  }

  // Load blog data into the form for editing.
  Future<void> _editBlog(Blog blog) async {
    setState(() {
      _authorNameController.text = blog.name; // Load the blog's author name.
      _authorAgeController.text =
          blog.age.toString(); // Load the blog's author age.
      _blogPostController.text = blog.post; // Load the blog content.
      _editingBlog = blog; // Set the blog being edited.
      _showTextFields = true; // Show the form for editing.
      _animationController.forward(); // Animate the form's appearance.
    });
  }

  // Delete a blog by its ID.
  Future<void> _deleteBlog(int id) async {
    await datasource.deleteBlog(id); // Delete the blog from the database.
    _fetchBlogs(); // Fetch updated list of blogs.
  }

  // Fetch all blogs from the database.
  Future<void> _fetchBlogs() async {
    final List<Blog> blogs =
        await datasource.blogs(); // Get the list of blogs from the database.
    setState(() {
      _blogs = blogs; // Update the local list of blogs.
      _showAllBlogs = true; // Show all blogs.
    });
  }

  // Delete all blogs from the database.
  Future<void> _deleteAllBlogs() async {
    await datasource.deleteAllBlogs(); // Delete all blogs from the database.
    _fetchBlogs(); // Fetch updated list of blogs (which should now be empty).
  }

  // Toggle the visibility of the form for adding or editing blogs.
  void _toggleTextFields() {
    setState(() {
      _showTextFields = !_showTextFields; // Toggle the form visibility.
      _editingBlog = null; // Clear the blog being edited.
      if (_showTextFields) {
        _animationController.forward(); // Show the form.
      } else {
        _animationController.reverse(); // Hide the form.
      }
    });
  }

  // Clear the form fields after saving or canceling.
  void _clearForm() {
    _authorNameController.clear(); // Clear author name input.
    _authorAgeController.clear(); // Clear author age input.
    _blogPostController.clear(); // Clear blog post content.
    setState(() {
      _editingBlog = null; // Clear any blog being edited.
      _showTextFields = false; // Hide the form.
    });
    _animationController.reverse(); // Hide the form with animation.
  }

  // Build the form for creating or updating a blog post.
  Widget _buildBlogForm() {
    return SizeTransition(
      sizeFactor:
          _textFieldOpacity, // Use opacity animation for form visibility.
      axisAlignment: 0.0, // Align the animation to the top.
      child: Column(
        children: [
          const Text(
            'Blog Post',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _authorNameController, // Input for the author's name.
            decoration: const InputDecoration(
              labelText: 'Author Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _authorAgeController, // Input for the author's age.
            decoration: const InputDecoration(
              labelText: 'Author Age',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // Accepts only numeric input.
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _blogPostController, // Input for the blog post content.
            decoration: const InputDecoration(
              labelText: 'Blog Post',
              border: OutlineInputBorder(),
            ),
            maxLines: 3, // Allow multiple lines for the blog post content.
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveBlog, // Save the blog when the button is pressed.
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              backgroundColor:
                  Theme.of(context).colorScheme.primary, // Button color.
            ),
            child: Text(
              _editingBlog != null
                  ? 'Update Post'
                  : 'Submit Post', // Change button label based on editing state.
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Build the list of blogs with swipe-to-delete functionality.
  Widget _buildBlogList() {
    return Expanded(
      child: _showAllBlogs
          ? ListView.builder(
              itemCount: _blogs.length, // Number of blogs to display.
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey<int>(
                      _blogs[index].id!), // Unique key for each blog.
                  direction:
                      DismissDirection.endToStart, // Swipe left to delete.
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red, // Red background when swiping to delete.
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete,
                        color: Colors.white), // Trash icon.
                  ),
                  onDismissed: (direction) {
                    _deleteBlog(
                        _blogs[index].id!); // Delete the blog when dismissed.
                  },
                  child: SizedBox(
                    width: double.infinity, // Ensure the card takes full width.
                    child: BlogCard(
                        blog: _blogs[index],
                        onEdit: _editBlog), // Display the blog in a card.
                  ),
                );
              },
            )
          : _lastInsertedBlog != null
              ? SingleChildScrollView(
                  child: SizedBox(
                      width:
                          double.infinity, // Ensure the card takes full width.
                      child: BlogCard(
                          blog: _lastInsertedBlog!,
                          onEdit: _editBlog)), // Show the last inserted blog.
                )
              : const Center(
                  child: Text(
                    'No recent blog available',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _showAllBlogs
                ? 'All Blogs'
                : 'Most Recent Post', // Change title based on view.
          ),
          actions: [
            IconButton(
              icon: Icon(_showAllBlogs
                  ? Icons.filter_list
                  : Icons.list), // Toggle icon for filtering.
              onPressed: () {
                setState(() {
                  _showAllBlogs =
                      !_showAllBlogs; // Toggle between all blogs and most recent.
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildBlogList(), // Display the list of blogs.
              if (_showTextFields) _buildBlogForm(), // Show the form if needed.
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              _toggleTextFields, // Toggle form visibility on button press.
          backgroundColor: Theme.of(context).colorScheme.primary,
          child:
              const Icon(Icons.add, color: Colors.white), // Add icon for FAB.
        ),
        // Smaller Drawer using FractionallySizedBox to control the width
        drawer: Navdrawer(
          isDarkMode: widget.isDarkMode,
          onThemeChanged: widget.onThemeChanged,
          deleteAllBlogs: _deleteAllBlogs,
        ));
  }
}
