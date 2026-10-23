import 'task.dart';

class Chapter {
  final String id;
  final String title;
  final String description;
  final String content;
  final String videoUrl;
  final int startSeconds;
  final int endSeconds;
  final String? pdfPath;
  final List<Task> tasks;

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.videoUrl,
    this.startSeconds = 0,
    this.endSeconds = 0,
    this.pdfPath,
    required this.tasks,
  });
}
