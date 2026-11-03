class ProjectRanking {
  const ProjectRanking({
    required this.id,
    required this.total,
    required this.ios,
    required this.android,
    required this.web,
    required this.updatedAt,
  });

  final String id;
  final int total;
  final int ios;
  final int android;
  final int web;
  final DateTime updatedAt;
}
