import 'package:mytodo/core/di/locator.dart';
import 'package:mytodo/data/datasources/local/app_local_storage.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';

class TaskRepository {
  final AppLocalStorage _localStorage = appLocalStorage;

  // Get current user's tasks
  List<Task> getCurrentUserTasks() {
    final currentUser = appGlobals.user;
    if (currentUser == null) return [];

    return getUserTasks(currentUser.id);
  }

  // Get tasks for specific user
  List<Task> getUserTasks(String userId) {
    final tasksJson = _localStorage.getUserTasks(userId);

    if (tasksJson == null) return [];

    try {
      return tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
    } catch (e) {
      print('Error loading tasks for user $userId: $e');
      return [];
    }
  }

  // Save tasks for current user
  Future<void> saveCurrentUserTasks(List<Task> tasks) async {
    final currentUser = appGlobals.user;
    if (currentUser == null) return;

    await saveUserTasks(currentUser.id, tasks);
  }

  // Save tasks for specific user
  Future<void> saveUserTasks(String userId, List<Task> tasks) async {
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    _localStorage.saveUserTasks(userId, tasksJson);
  }

  // Create new task for current user
  Future<Task?> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required String category,
    Priority priority = Priority.medium,
    String? notes,
    List<String> tags = const [],
    String? reminderTime,
  }) async {
    final currentUser = appGlobals.user;
    if (currentUser == null) return null;

    final task = Task(
      id: _generateTaskId(),
      title: title,
      description: description,
      dueDate: dueDate,
      category: category,
      priority: priority,
      notes: notes,
      tags: tags,
      reminderTime: reminderTime,
    );

    final currentTasks = getCurrentUserTasks();
    currentTasks.add(task);
    await saveCurrentUserTasks(currentTasks);

    return task;
  }

  // Update existing task
  Future<bool> updateTask(Task updatedTask) async {
    final currentUser = appGlobals.user;
    if (currentUser == null) return false;

    // Ensure the task belongs to current user
    if (updatedTask.createdBy != currentUser.email) {
      print('Cannot update task: Task does not belong to current user');
      return false;
    }

    final currentTasks = getCurrentUserTasks();
    final taskIndex = currentTasks.indexWhere(
      (task) => task.id == updatedTask.id,
    );

    if (taskIndex == -1) return false;

    currentTasks[taskIndex] = updatedTask;
    await saveCurrentUserTasks(currentTasks);

    return true;
  }

  // Delete task
  Future<bool> deleteTask(String taskId) async {
    final currentUser = appGlobals.user;
    if (currentUser == null) return false;

    final currentTasks = getCurrentUserTasks();
    final taskIndex = currentTasks.indexWhere((task) => task.id == taskId);

    if (taskIndex == -1) return false;

    // Ensure the task belongs to current user
    final taskToDelete = currentTasks[taskIndex];
    if (taskToDelete.createdBy != currentUser.email) {
      print('Cannot delete task: Task does not belong to current user');
      return false;
    }

    currentTasks.removeAt(taskIndex);
    await saveCurrentUserTasks(currentTasks);

    return true;
  }

  // Toggle task completion status
  Future<bool> toggleTaskCompletion(String taskId) async {
    final currentUser = appGlobals.user;
    if (currentUser == null) return false;

    final currentTasks = getCurrentUserTasks();
    final taskIndex = currentTasks.indexWhere((task) => task.id == taskId);

    if (taskIndex == -1) return false;

    final task = currentTasks[taskIndex];

    // Ensure the task belongs to current user
    if (task.createdBy != currentUser.email) {
      print('Cannot modify task: Task does not belong to current user');
      return false;
    }

    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      completedAt: !task.isCompleted ? DateTime.now() : null,
    );

    currentTasks[taskIndex] = updatedTask;
    await saveCurrentUserTasks(currentTasks);

    return true;
  }

  // Get tasks by status for current user
  List<Task> getTasksByStatus(String status) {
    final tasks = getCurrentUserTasks();

    switch (status.toLowerCase()) {
      case 'ongoing':
      case 'pending':
        return tasks.where((task) => !task.isCompleted).toList();
      case 'completed':
        return tasks.where((task) => task.isCompleted).toList();
      case 'overdue':
        return tasks.where((task) => task.isOverdue).toList();
      default:
        return tasks;
    }
  }

  // Get tasks by category for current user
  List<Task> getTasksByCategory(String category) {
    final tasks = getCurrentUserTasks();
    return tasks
        .where((task) => task.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Search tasks for current user
  List<Task> searchTasks(String query) {
    final tasks = getCurrentUserTasks();
    final searchQuery = query.toLowerCase();

    return tasks
        .where(
          (task) =>
              task.title.toLowerCase().contains(searchQuery) ||
              task.description.toLowerCase().contains(searchQuery) ||
              task.category.toLowerCase().contains(searchQuery) ||
              task.tags.any((tag) => tag.toLowerCase().contains(searchQuery)),
        )
        .toList();
  }

  // Get task statistics for current user
  Map<String, int> getTaskStatistics() {
    final tasks = getCurrentUserTasks();

    return {
      'total': tasks.length,
      'completed': tasks.where((task) => task.isCompleted).length,
      'pending': tasks.where((task) => !task.isCompleted).length,
      'overdue': tasks.where((task) => task.isOverdue).length,
      'dueToday': tasks
          .where((task) => task.isDueToday && !task.isCompleted)
          .length,
      'dueTomorrow': tasks
          .where((task) => task.isDueTomorrow && !task.isCompleted)
          .length,
    };
  }

  // Generate unique task ID
  String _generateTaskId() {
    return 'task_${DateTime.now().millisecondsSinceEpoch}_${appGlobals.user?.id ?? 'unknown'}';
  }

  // Called when user switches accounts
  Future<void> onUserSwitched() async {
    // This method can be called when switching users to ensure
    // the app loads the correct user's tasks
    final currentUser = appGlobals.user;
    if (currentUser == null) return;

    // Tasks are automatically loaded by getCurrentUserTasks()
    // This method exists for potential future cache invalidation
  }

  // Cleanup tasks for deleted user (optional utility method)
  Future<void> deleteAllTasksForUser(String userId) async {
    _localStorage.deleteUserTasks(userId);
  }
}
