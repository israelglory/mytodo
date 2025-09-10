import 'dart:developer';

import 'package:mytodo/presentation/task/create_task/create_task_view.dart';
import 'package:stacked/stacked.dart';
import 'package:mytodo/data/repo/task_repository.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';

import '../../core/cores.dart';

class HomeViewmodel extends BaseViewModel {
  final TaskRepository _taskRepository = TaskRepository();

  int _currentCarouselIndex = 0;
  List<Task> _todaysTasks = [];

  int get currentCarouselIndex => _currentCarouselIndex;
  List<Task> get todaysTasks => _todaysTasks;

  void initialise() {
    loadTodaysTasks();
  }

  void setCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  // Load tasks that are due today
  void loadTodaysTasks() {
    setBusy(true);
    try {
      final allTasks = _taskRepository.getCurrentUserTasks();
      _todaysTasks = allTasks
          .where((task) => task.isDueToday && !task.isCompleted)
          .toList();
      notifyListeners();
    } catch (e) {
      log('Error loading today\'s tasks: $e');
    } finally {
      setBusy(false);
    }
  }

  // Toggle task completion
  Future<void> toggleTaskStatus(String taskId, bool isCompleted) async {
    setBusy(true);
    try {
      final success = await _taskRepository.toggleTaskCompletion(taskId);
      if (success) {
        loadTodaysTasks(); // Reload to get updated list
      }
    } catch (e) {
      log('Error toggling task status: $e');
    } finally {
      setBusy(false);
    }
  }

  // Edit task - navigate to edit view
  void editTask(Task task) {
    navigationService
        .push(
          CreateTaskView(task: task),
        )
        .then((_) => loadTodaysTasks());
  }

  // Delete task with confirmation
  Future<void> deleteTaskWithConfirmation(Task task) async {
    setBusy(true);
    try {
      final success = await _taskRepository.deleteTask(task.id);
      if (success) {
        loadTodaysTasks(); // Reload today's tasks
        snackbarService.success(message: 'Task deleted successfully');
      } else {
        snackbarService.error(message: 'Failed to delete task');
      }
    } catch (e) {
      log('Error deleting task: $e');
      snackbarService.error(message: 'Failed to delete task');
    } finally {
      setBusy(false);
    }
  }

  List<String> quotes = [
    AppAssets.quote1,
    AppAssets.quote2,
    AppAssets.quote3,
    AppAssets.quote4,
    AppAssets.quote5,
    AppAssets.quote6,
  ];
}
