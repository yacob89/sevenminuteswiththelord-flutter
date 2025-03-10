class ActivityData {
  final String id;
  final String title;
  final String description;
  final int durationInSeconds;

  ActivityData({
    required this.id,
    required this.title,
    required this.description,
    required this.durationInSeconds,
  });
  
  // Clone the activity with optional modified properties
  ActivityData copyWith({
    String? id,
    String? title,
    String? description,
    int? durationInSeconds,
  }) {
    return ActivityData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
    );
  }
}