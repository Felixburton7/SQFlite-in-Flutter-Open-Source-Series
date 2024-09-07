import 'package:persist_data_example_sqlite/data/models/blog_model.dart';
import 'package:sqflite/sqflite.dart'; // SQLite database package for Flutter.
import 'package:path/path.dart'; // Provides utilities for file path manipulation.

class Datasource {
  Database? _database; // Holds the SQLite database instance.

  // Initialize the database and store the instance in a field.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // If the database is not initialized, open it and store it in _database.
    _database = await openDatabase(
      join(await getDatabasesPath(),
          'blogs_database.db'), // Create the database file.
      onCreate: (db, version) {
        // Create the blogs table when the database is first created.
        return db.execute(
          'CREATE TABLE blogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, post TEXT)',
        );
      },
      version: 1, // Database version.
    );
    return _database!;
  }

  // Insert a blog entry into the database.
  Future<void> insertBlog(Blog blog) async {
    final db = await database; // Get a reference to the database.
    await db.insert(
      'blogs', // Insert into the blogs table.
      blog.toMap(), // Convert the Blog object into a Map.
      conflictAlgorithm:
          ConflictAlgorithm.replace, // If the blog already exists, replace it.
    );
  }

  // Retrieve all blog entries from the blogs table.
  Future<List<Blog>> blogs() async {
    final db = await database; // Get a reference to the database.

    // Query the table for all blogs.
    final List<Map<String, Object?>> blogMaps = await db.query('blogs');

    // Convert the List<Map> to a List<Blog> and return it.
    return [
      for (final Map<String, Object?> blogMap in blogMaps)
        Blog(
          id: blogMap['id'] as int,
          name: blogMap['name'] as String,
          age: blogMap['age'] as int,
          post: blogMap['post'] as String,
        ),
    ];
  }

  // Update an existing blog entry in the database.
  Future<void> updateBlog(Blog blog) async {
    final db = await database; // Get a reference to the database.

    // Update the blog with the matching ID.
    await db.update(
      'blogs', // Update in the blogs table.
      blog.toMap(), // Convert the updated Blog object to a Map.
      where:
          'id = ?', // Ensure the update targets the blog with the correct ID.
      whereArgs: [blog.id], // Pass the blog ID to prevent SQL injection.
    );
  }

  // Delete a blog entry from the database.
  Future<void> deleteBlog(int id) async {
    final db = await database; // Get a reference to the database.

    // Delete the blog with the matching ID.
    await db.delete(
      'blogs', // Delete from the blogs table.
      where: 'id = ?', // Specify which blog to delete using the ID.
      whereArgs: [id], // Pass the blog ID to prevent SQL injection.
    );
  }

  // Delete all blog entries from the database.
  Future<void> deleteAllBlogs() async {
    final db = await database; // Get a reference to the database.

    // Delete all rows from the blogs table.
    await db.delete('blogs');
  }
}
