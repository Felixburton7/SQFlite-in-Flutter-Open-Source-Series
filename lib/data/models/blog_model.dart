class Blog {
  final int? id; // Unique identifier for each blog entry.
  final String name; // Author's name.
  final int age; // Author's age.
  final String post; // The blog post content.

  Blog({
    this.id, // Constructor requires all fields.
    required this.name,
    required this.age,
    required this.post,
  });

  // Converts the Blog instance into a Map that matches the structure of the database table.
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age, 'post': post};
  }

  // Overrides the toString method to make it easier to print Blog details.
  @override
  String toString() {
    return 'Blog{id: $id, name: $name, age: $age, post: $post}';
  }
}
