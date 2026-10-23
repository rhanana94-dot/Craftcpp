abstract class Task {
  final String id;
  Task(this.id);
}

class QuizTask extends Task {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizTask({
    required String id,
    required this.question,
    required this.options,
    required this.correctIndex,
  }) : super(id);
}

class PracticeTask extends Task {
  final String description;
  final String expectedOutput;
  final String targetCodeSnippet;

  PracticeTask({
    required String id,
    required this.description,
    required this.expectedOutput,
    required this.targetCodeSnippet,
  }) : super(id);
}
