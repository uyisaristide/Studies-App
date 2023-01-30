import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/student.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]);

  Future<void> saveStudent(Student newStudent) async {
    // final isar = await db;
    isarDb.writeTxnSync<int>(() => isarDb.students.putSync(newStudent));
    state = [...state, newStudent];
  }

  Future<List<Student>> getAllStudents() async {
    state = await isarDb.students.where().findAll();
    return state;
  }
}
