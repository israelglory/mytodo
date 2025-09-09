class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String category;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final Priority priority;
  final String? notes;
  final List<String> tags;
  final String? reminderTime; // Time before due date to remind
  final String? assignedTo;
  final String? projectId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    this.isCompleted = false,
    DateTime? createdAt,
    this.completedAt,
    this.priority = Priority.medium,
    this.notes,
    this.tags = const [],
    this.reminderTime,
    this.assignedTo,
    this.projectId,
  }) : createdAt = createdAt ?? DateTime.now();

  // Copy with method for updating task properties
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? category,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    Priority? priority,
    String? notes,
    List<String>? tags,
    String? reminderTime,
    String? assignedTo,
    String? projectId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      reminderTime: reminderTime ?? this.reminderTime,
      assignedTo: assignedTo ?? this.assignedTo,
      projectId: projectId ?? this.projectId,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'category': category,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'priority': priority.name,
      'notes': notes,
      'tags': tags,
      'reminderTime': reminderTime,
      'assignedTo': assignedTo,
      'projectId': projectId,
    };
  }

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      priority: Priority.values.firstWhere(
        (p) => p.name == json['priority'],
        orElse: () => Priority.medium,
      ),
      notes: json['notes'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      reminderTime: json['reminderTime'] as String?,
      assignedTo: json['assignedTo'] as String?,
      projectId: json['projectId'] as String?,
    );
  }

  // Helper methods
  bool get isOverdue => !isCompleted && DateTime.now().isAfter(dueDate);
  bool get isDueToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDueDate = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return today.isAtSameMomentAs(taskDueDate);
  }

  bool get isDueTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final taskDueDate = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return tomorrow.isAtSameMomentAs(taskDueDate);
  }

  Duration get timeUntilDue => dueDate.difference(DateTime.now());

  String get formattedDueDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (taskDate.isAtSameMomentAs(today)) {
      return 'Today, ${_formatTime(dueDate)}';
    } else if (taskDate.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
      return 'Tomorrow, ${_formatTime(dueDate)}';
    } else if (taskDate.isAtSameMomentAs(
      today.subtract(const Duration(days: 1)),
    )) {
      return 'Yesterday, ${_formatTime(dueDate)}';
    } else {
      return '${_formatDate(dueDate)}, ${_formatTime(dueDate)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour == 0
        ? 12
        : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Task(id: $id, title: $title, dueDate: $dueDate, isCompleted: $isCompleted)';
  }
}

// Priority enum
enum Priority {
  low,
  medium,
  high,
  urgent;

  String get displayName {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      case Priority.urgent:
        return 'Urgent';
    }
  }

  // Get color for priority
  int get colorValue {
    switch (this) {
      case Priority.low:
        return 0xFF4CAF50; // Green
      case Priority.medium:
        return 0xFF2196F3; // Blue
      case Priority.high:
        return 0xFFFF9800; // Orange
      case Priority.urgent:
        return 0xFFF44336; // Red
    }
  }
}

// Task status enum (additional status beyond just completed)
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }
}
