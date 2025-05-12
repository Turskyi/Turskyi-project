class SupportFormData {
  const SupportFormData({
    required this.name,
    required this.email,
    required this.message,
  });

  final String name;
  final String email;
  final String message;

  SupportFormData copyWith({
    String? name,
    String? email,
    String? message,
  }) {
    return SupportFormData(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }
}
