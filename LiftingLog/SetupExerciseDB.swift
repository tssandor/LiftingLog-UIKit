//
//  SetupExerciseDB.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

var exerciseTypeDB: [ExerciseType] = []

var workouts: [Workout] = []

func setupExerciseDB() {
//  exerciseTypeDB.append(ExerciseType(exerciseName: "-- SELECT EXERCISE --", exerciseCategory: "Barbell"))
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
  print(jsonString)
  
  let url = getDocumentsDirectory().appendingPathComponent("workoutsJSON.json")
  do {
    try jsonString.write(to: url, atomically: true, encoding: .utf8)
    let input = try String(contentsOf: url)
    print(input)
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

//extension Bundle {
//    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let path = paths[0]
//        let url = path.appendingPathComponent("workoutsJSON.json")
//
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = dateDecodingStrategy
//        decoder.keyDecodingStrategy = keyDecodingStrategy
//
//        do {
//            return try decoder.decode(T.self, from: data)
//        } catch DecodingError.keyNotFound(let key, let context) {
//            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
//        } catch DecodingError.typeMismatch(_, let context) {
//            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
//        } catch DecodingError.dataCorrupted(_) {
//            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
//        } catch {
//            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
//        }
//    }
//}
//
//extension JSONSerialization {
//    static func loadJSON(withFilename filename: String) throws -> Any? {
//        let fm = FileManager.default
//        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
//        if let url = urls.first {
//            var fileURL = url.appendingPathComponent(filename)
//            fileURL = fileURL.appendingPathExtension("json")
//            let data = try Data(contentsOf: fileURL)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
//            return jsonObject
//        }
//        return nil
//    }
//
//    static func saveJSON(jsonObject: Any, toFilename filename: String) throws -> Bool{
//        let fm = FileManager.default
//        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
//        if let url = urls.first {
//            var fileURL = url.appendingPathComponent(filename)
//            fileURL = fileURL.appendingPathExtension("json")
//            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
//            try data.write(to: fileURL, options: [.atomicWrite])
//            return true
//        }
//
//        return false
//    }
//}

