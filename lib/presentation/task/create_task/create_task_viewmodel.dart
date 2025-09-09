import 'package:flutter/material.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class CreateTaskViewModel extends BaseViewModel {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Priority selectedPriority = Priority.medium;

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

  Task? createTask(BuildContext context) {
    if (!canCreateTask) return null;

    final task = Task(
      id: const Uuid().v4(),
      title: taskTitleController.text.trim(),
      description: taskDescriptionController.text.trim(),
      dueDate: combinedDateTime!,
      category: categoryController.text.trim(),
      priority: selectedPriority,
      tags: _extractTags(taskDescriptionController.text),
    );

    // Clear form
    _clearForm();

    // Navigate back
    Navigator.pop(context, task);

    return task;
  }

  List<String> _extractTags(String description) {
    // Simple tag extraction - you can make this more sophisticated
    final words = description.toLowerCase().split(' ');
    return words.where((word) => word.length > 3).take(3).toList();
  }

  void _clearForm() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    categoryController.clear();
    selectedDate = null;
    selectedTime = null;
    selectedPriority = Priority.medium;
    notifyListeners();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }
}
