class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name
  });

  factory Category.fromJson(Map<String, dynamic> data) {
    final name = data['name'] == null ? 'UNkown' : data['name'];
    return Category(id: data['id'],name: name);
  } 
}