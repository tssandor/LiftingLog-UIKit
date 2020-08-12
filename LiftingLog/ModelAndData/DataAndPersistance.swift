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
  
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Arnold Press", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Around The World", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Back Extension (dumbbell)", exerciseCategory: .dumbbell))
//  // back extension is done with plates sometimes, or body weight
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Back Extension (plates)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press Close Grip (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press Wide Grip (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row One Arm", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row Underhand (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Box Squat", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Bulgarian Split Squat", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Chest Fly", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Clean", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Clean and Jerk", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Concentration Curl", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift High Pull (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Decline Bench Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Decline Bench Press (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Front Raise (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Front Raise (dumbbell)", exerciseCategory: .dumbbell))
//  // this needs to be plates
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Front Raise (plates)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Front Squat (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Good Morning (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Hack Squat (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Front Squat (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Hammer Curl (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Hang Clean (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Hang Snatch (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Hip Thrust (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Incline Bench Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Incline Bench Press (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Incline Curl (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Incline Row (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Lateral Raise (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Lunge (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Lunge (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Military Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Overhead Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Overhead Press (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Overhead Squat (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Power Clean (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Power Snatch (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Preacher Curl (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Preacher Curl (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Pullover (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Push Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Reverse Curl (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Reverse Curl (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Reverse Fly (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Romanian Deadlift (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Romanian Deadlift (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Seated Overhead Press (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Seated Overhead Press (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Shrug (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Shrug (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Side Bend (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Skullcrusher (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Skullcrusher (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Snatch (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Snatch Pull (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Split Jerk (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Squat (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Squat (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Standing Calf Raise (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Standing Calf Raise (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Sumo Deadlift (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Sumo Deadlift High Pull (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Trap Bar Deadlift (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Triceps Extension (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Triceps Extension (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Upright Row (barbell)", exerciseCategory: .barbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Upright Row (dumbbell)", exerciseCategory: .dumbbell))
//  exerciseTypeDB.append(ExerciseType(exerciseName: "Zercher Squat (barbell)", exerciseCategory: .barbell))
//
//  print(exerciseTypeDB)
//  print("\n\n")
//
//  exerciseTypeDB = []
  
  exerciseTypeDB = Bundle.main.decode([ExerciseType].self, from: "exerciseDB.json")
  
//  print(exerciseTypeDB)
//  let encoder = JSONEncoder()
//  encoder.outputFormatting = .prettyPrinted
//  let jsonData = try! encoder.encode(exerciseTypeDB)
//  let jsonString = String(data: jsonData, encoding: .utf8)!
//  let url = getDocumentsDirectory().appendingPathComponent("exerciseDB.json")
//  print(url)
//  do {
//    try jsonString.write(to: url, atomically: true, encoding: .utf8)
//  } catch {
//    print(error.localizedDescription)
//  }
  
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

// Bundle extension from Hacking With Swift, makes it possible to decode JSON from the Bundle with one line of code
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
