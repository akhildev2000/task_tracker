class Task {
  String id;
  String title;
  String description;
  String employeeId;
  String comments;
  bool isComplete;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.employeeId,
      required this.isComplete,
      required this.comments});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'employeeId': employeeId,
      'comments': comments,
      'isComplete': isComplete ? 1 : 0,
    };
  }
}
