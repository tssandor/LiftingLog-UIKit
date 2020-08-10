//
//  DataAndPersistance.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

var exerciseTypeDB: [ExerciseType] = []

var workouts: [Workout] = []

func setupExerciseDB() {
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (Barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (Dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (Dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 1", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 2", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 3", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 4", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 5", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Dummy 6", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Arnold Press", exerciseCategory: .dumbbell))
}

var weightUnit: String = "kg"

var setsForEquipmentType: [Equipment:[Int]] = [
  .barbell :    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
  .dumbbell:    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
]

var repsForEquipmentType: [Equipment:[Int]] = [
  .barbell :    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
  .dumbbell:   [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
]

var weightsForEquipmentType: [Equipment:[Float]] = [
  .barbell :    [20, 22.5, 25, 27.5, 30, 32.5, 35, 37.5, 40, 42.5, 45, 47.5, 50, 52.5, 55, 57.5, 60, 62.5, 65, 333.5],
  .dumbbell:   [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
]

func getDocumentsDirectory() -> URL {
  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
  return paths[0]
}

func saveWorkoutsToJSON() {
  let jsonData = try! JSONEncoder().encode(workouts)
  let jsonString = String(data: jsonData, encoding: .utf8)!
  let url = getDocumentsDirectory().appendingPathComponent("workoutsJSON.json")
  do {
    try jsonString.write(to: url, atomically: true, encoding: .utf8)
  } catch {
    print(error.localizedDescription)
  }
}

func loadWorkoutsFromJSON() -> Bool {
  let url = getDocumentsDirectory().appendingPathComponent("workoutsJSON.json")
  guard let data = try? Data(contentsOf: url) else {
    workouts = []
    return false
  }
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .deferredToDate
  decoder.keyDecodingStrategy = .useDefaultKeys
  do {
    try workouts = decoder.decode([Workout].self, from: data)
  }
  catch {
    workouts = []
  }
  return true
}
