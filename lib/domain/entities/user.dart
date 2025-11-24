class User {
  final String name;
  final String email;
  final String? photoUrl;

  const User({
    required this.name,
    required this.email,
    this.photoUrl,
  });
}
