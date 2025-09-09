import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:stacked/stacked.dart';

class TaskViewModel extends BaseViewModel {
  List<Task> tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter project',
      description:
          'Finish the task management app with all required features including notifications and data persistence.',
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      category: 'Work',
      priority: Priority.high,
      tags: ['flutter', 'mobile', 'deadline'],
      notes: 'Focus on UI improvements and testing',
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Grocery Shopping',
      description:
          'Buy vegetables, fruits, milk, bread, and other essentials for the week.',
      dueDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
      category: 'Personal',
      priority: Priority.medium,
      tags: ['shopping', 'food'],
      isCompleted: false,
    ),
    Task(
      id: '3',
      title: 'Team Meeting',
      description:
          'Weekly standup meeting to discuss project progress and upcoming milestones.',
      dueDate: DateTime.now().add(const Duration(hours: 1)),
      category: 'Work',
      priority: Priority.urgent,
      tags: ['meeting', 'team', 'standup'],
      notes: 'Prepare status report',
      isCompleted: false,
    ),
    Task(
      id: '4',
      title: 'Exercise - Morning Run',
      description:
          'Go for a 5km morning run in the park. Focus on maintaining steady pace.',
      dueDate: DateTime.now().add(const Duration(days: 1, hours: -2)),
      category: 'Health',
      priority: Priority.medium,
      tags: ['exercise', 'running', 'health'],
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Task(
      id: '5',
      title: 'Read Chapter 5',
      description:
          'Read and take notes on Chapter 5 of "Clean Architecture" book.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      category: 'Learning',
      priority: Priority.low,
      tags: ['reading', 'architecture', 'learning'],
    ),
    Task(
      id: '6',
      title: 'Doctor Appointment',
      description: 'Annual health checkup appointment with Dr. Smith.',
      dueDate: DateTime.now().add(const Duration(days: 3, hours: 2)),
      category: 'Health',
      priority: Priority.high,
      tags: ['health', 'appointment', 'checkup'],
      notes: 'Bring insurance card and previous reports',
      isCompleted: false,
    ),
    Task(
      id: '7',
      title: 'Code Review',
      description:
          'Review pull requests from team members and provide feedback.',
      dueDate: DateTime.now().subtract(const Duration(hours: 1)),
      category: 'Work',
      priority: Priority.urgent,
      tags: ['code-review', 'development'],
      isCompleted: false,
      notes: 'Focus on security and performance',
    ),
    Task(
      id: '8',
      title: 'Plan Weekend Trip',
      description:
          'Plan and book accommodation for weekend getaway to the mountains.',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      category: 'Personal',
      priority: Priority.low,
      tags: ['travel', 'planning', 'weekend'],
      isCompleted: false,
    ),
    Task(
      id: '9',
      title: 'Update Resume',
      description:
          'Update resume with recent projects and skills. Review and polish formatting.',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      category: 'Career',
      priority: Priority.medium,
      tags: ['resume', 'career', 'update'],
      isCompleted: false,
    ),
    Task(
      id: '10',
      title: 'Water Plants',
      description:
          'Water all indoor and outdoor plants. Check for any signs of pests or disease.',
      dueDate: DateTime.now().add(const Duration(hours: 6)),
      category: 'Home',
      priority: Priority.low,
      tags: ['plants', 'gardening', 'maintenance'],
      isCompleted: false,
    ),
  ];
  bool isCompleted = false;
  int selectedIndex = 0;
  void toggleCompleted(bool value) {
    isCompleted = value;
    notifyListeners();
  }

  List<Task> getTasksByCategory(String category) {
    switch (category) {
      case 'Work':
        return tasks.where((task) => task.category == 'Work').toList();
      case 'Personal':
        return tasks.where((task) => task.category == 'Personal').toList();
      case 'Health':
        return tasks.where((task) => task.category == 'Health').toList();
      case 'Learning':
        return tasks.where((task) => task.category == 'Learning').toList();
      case 'Career':
        return tasks.where((task) => task.category == 'Career').toList();
      case 'Home':
        return tasks.where((task) => task.category == 'Home').toList();
      default:
        return tasks;
    }
  }

  List<Task> getTasksByStatus(String status) {
    switch (status) {
      case 'ongoing':
        return tasks.where((task) => !task.isCompleted).toList();
      case 'completed':
        return tasks.where((task) => task.isCompleted).toList();
      default:
        return tasks;
    }
  }

  void toggleTaskStatus(String taskId, bool isCompleted) {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex] = tasks[taskIndex].copyWith(
        isCompleted: isCompleted,
        completedAt: isCompleted ? DateTime.now() : null,
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        notifyListeners();
      });
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
