import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:mytodo/data/repo/task_repository.dart';
import 'package:mytodo/core/di/locator.dart';
import 'package:stacked/stacked.dart';

class CreateTaskViewModel extends BaseViewModel {
  final TaskRepository _taskRepository = TaskRepository();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Priority selectedPriority = Priority.medium;
  List<String> _tags = [];

  // Initialize with existing task data if editing
  void initializeWithTask(Task? task) {
    if (task != null) {
      taskTitleController.text = task.title;
      taskDescriptionController.text = task.description;
      categoryController.text = task.category;
      notesController.text = task.notes ?? '';
      selectedDate = task.dueDate;
      selectedTime = TimeOfDay(
        hour: task.dueDate.hour,
        minute: task.dueDate.minute,
      );
      selectedPriority = task.priority;
      _tags = List.from(task.tags);
      notifyListeners();
    }
  }

  // Getters
  bool get canCreateTask {
    return taskTitleController.text.isNotEmpty &&
        taskDescriptionController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        selectedDate != null &&
        selectedTime != null;
  }

  DateTime? get combinedDateTime {
    if (selectedDate != null && selectedTime != null) {
      return DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    }
    return null;
  }

  List<String> get tags => _tags;

  // Methods
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      notifyListeners();
    }
  }

  void setPriority(Priority priority) {
    selectedPriority = priority;
    notifyListeners();
  }

  // Add tag
  void addTag(String tag) {
    if (tag.trim().isNotEmpty && !_tags.contains(tag.trim())) {
      _tags.add(tag.trim());
      notifyListeners();
    }
  }

  // Remove tag
  void removeTag(String tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  // Create task using repository
  Future<Task?> createTask() async {
    if (!canCreateTask) return null;

    setBusy(true);
    try {
      final task = await _taskRepository.createTask(
        title: taskTitleController.text.trim(),
        description: taskDescriptionController.text.trim(),
        dueDate: combinedDateTime!,
        category: categoryController.text.trim(),
        priority: selectedPriority,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        tags: _tags,
      );

      if (task != null) {
        _clearForm();
        navigationService.pop();
      }

      return task;
    } catch (e) {
      log('Error creating task: $e');
      return null;
    } finally {
      setBusy(false);
    }
  }

  void _clearForm() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    categoryController.clear();
    notesController.clear();
    selectedDate = null;
    selectedTime = null;
    selectedPriority = Priority.medium;
    _tags.clear();
    notifyListeners();
  }

  Future<bool> updateTask(Task task) async {
    if (!canCreateTask) return false;

    setBusy(true);
    try {
      final updatedTask = task.copyWith(
        title: taskTitleController.text.trim(),
        description: taskDescriptionController.text.trim(),
        category: categoryController.text.trim(),
        dueDate: combinedDateTime!,
        priority: selectedPriority,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        tags: _tags,
      );

      final success = await _taskRepository.updateTask(updatedTask);

      if (success) {
        navigationService.pop();
        return true;
      }

      return false;
    } catch (e) {
      log('Error updating task: $e');
      return false;
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    categoryController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
