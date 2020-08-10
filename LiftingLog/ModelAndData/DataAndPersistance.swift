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
  
  setupWeights()
  
  exerciseTypeDB.append(ExerciseType(exerciseName: "Arnold Press", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Around The World", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Back Extension", exerciseCategory: .dumbbell)) // this is plates
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press (dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press Close Grip (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press Wide Grip (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row One Arm", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row Underhand (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (barbell)", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Box Squat", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bulgarian Split Squat", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Chest Fly", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Clean", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Clean and Jerk", exerciseCategory: .barbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Concentration Curl", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift (dumbbell)", exerciseCategory: .dumbbell))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift (barbell)", exerciseCategory: .barbell))
  
  let jsonData = try! JSONEncoder().encode(exerciseTypeDB)
  let jsonString = String(data: jsonData, encoding: .utf8)!
  let url = getDocumentsDirectory().appendingPathComponent("exerciseDB.json")
  print(url)
  do {
    try jsonString.write(to: url, atomically: true, encoding: .utf8)
  } catch {
    print(error.localizedDescription)
  }
  
}

var weightUnit: String = "kg"

var setsForEquipmentType: [Equipment:[Int]] = [
  .barbell :    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
  .dumbbell:    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
]

var repsForEquipmentType: [Equipment:[Int]] = [
  .barbell :    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
  .dumbbell:   [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
]

var weightsForEquipmentType: [Equipment:[Float]] = [
  .barbell : [],
  .dumbbell: []
]

func setupWeights() {
  var weights: [Float] = []
  var weightForBarbell = 20.0
  var weightForDumbbell = 1.0
  for _ in 1...113 {
    weights.append(Float(weightForBarbell))
    weightForBarbell += 2.5
  }
  weightsForEquipmentType[.barbell] = weights
  weights = []
  for _ in 1...50 {
    weights.append(Float(weightForDumbbell))
    weightForDumbbell += 1
  }
  weightsForEquipmentType[.dumbbell] = weights
}

// ***
// JSON METHODS
// ***

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
