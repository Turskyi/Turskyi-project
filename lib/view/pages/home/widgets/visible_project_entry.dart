import 'package:turskyi/model/models/project.dart';

class VisibleProjectEntry {
  const VisibleProjectEntry({
    required this.project,
    this.isVisible = true,
    this.isRemoving = false,
  });

  final Project project;
  final bool isVisible;
  final bool isRemoving;

  VisibleProjectEntry copyWith({
    final Project? project,
    final bool? isVisible,
    final bool? isRemoving,
  }) {
    return VisibleProjectEntry(
      project: project ?? this.project,
      isVisible: isVisible ?? this.isVisible,
      isRemoving: isRemoving ?? this.isRemoving,
    );
  }
}
