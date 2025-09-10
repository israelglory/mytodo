import 'dart:developer';

import 'package:mytodo/core/di/locator.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:mytodo/data/repo/task_repository.dart';
import 'package:mytodo/presentation/task/create_task/create_task_view.dart';
import 'package:stacked/stacked.dart';

class TaskViewModel extends BaseViewModel {
  final TaskRepository _taskRepository = TaskRepository();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  int selectedIndex = 0;

  void initialise() {
    loadCurrentUserTasks();
  }

  // Load tasks for current user
  void loadCurrentUserTasks() {
    setBusy(true);
    try {
      _tasks = _taskRepository.getCurrentUserTasks();
      notifyListeners();
    } catch (e) {
      log('Error loading tasks: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> refreshTasks() async {
    await _taskRepository.onUserSwitched();
    loadCurrentUserTasks();
  }

  List<Task> getTasksByCategory(String category) {
    return _taskRepository.getTasksByCategory(category);
  }

  List<Task> getTasksByStatus(String status) {
    return _taskRepository.getTasksByStatus(status);
  }

  Future<void> toggleTaskStatus(String taskId, bool isCompleted) async {
    setBusy(true);
    try {
      final success = await _taskRepository.toggleTaskCompletion(taskId);
      if (success) {
        loadCurrentUserTasks();
        Future.delayed(const Duration(milliseconds: 300), () {
          notifyListeners();
        });
      }
    } catch (e) {
      log('Error toggling task status: $e');
    } finally {
      setBusy(false);
    }
  }

  // Create new task
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
    setBusy(true);
    try {
      final task = await _taskRepository.createTask(
        title: title,
        description: description,
        dueDate: dueDate,
        category: category,
        priority: priority,
        notes: notes,
        tags: tags,
        reminderTime: reminderTime,
      );

      if (task != null) {
        loadCurrentUserTasks(); // Reload to show new task
      }

      return task;
    } catch (e) {
      log('Error creating task: $e');
      return null;
    } finally {
      setBusy(false);
    }
  }

  // Update existing task
  Future<bool> updateTask(Task updatedTask) async {
    setBusy(true);
    try {
      final success = await _taskRepository.updateTask(updatedTask);
      if (success) {
        loadCurrentUserTasks(); // Reload to show updated task
      }
      return success;
    } catch (e) {
      log('Error updating task: $e');
      return false;
    } finally {
      setBusy(false);
    }
  }

  // Delete task
  Future<bool> deleteTask(String taskId) async {
    setBusy(true);
    try {
      final success = await _taskRepository.deleteTask(taskId);
      if (success) {
        loadCurrentUserTasks(); // Reload to remove deleted task
      }
      return success;
    } catch (e) {
      log('Error deleting task: $e');
      return false;
    } finally {
      setBusy(false);
    }
  }

  // Search tasks
  List<Task> searchTasks(String query) {
    return _taskRepository.searchTasks(query);
  }

  // Get task statistics
  Map<String, int> getTaskStatistics() {
    return _taskRepository.getTaskStatistics();
  }

  // Called when user switches accounts
  void onUserSwitched() {
    _tasks.clear();
    loadCurrentUserTasks();
  }

  // Set selected tab index
  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // Get item count for AnimatedList
  int getItemCount() {
    final statusTasks = getTasksByStatus(
      selectedIndex == 0 ? 'ongoing' : 'completed',
    );
    return statusTasks.length;
  }

  // Edit task - navigate to edit view
  void editTask(Task task) {
    navigationService
        .push(
          CreateTaskView(task: task),
        )
        .then((_) => loadCurrentUserTasks());
  }

  // Delete task with confirmation
  Future<void> deleteTaskWithConfirmation(Task task) async {
    final success = await deleteTask(task.id);
    if (success) {
      snackbarService.success(message: 'Task deleted successfully');
    } else {
      snackbarService.error(message: 'Failed to delete task');
    }
  }
}
