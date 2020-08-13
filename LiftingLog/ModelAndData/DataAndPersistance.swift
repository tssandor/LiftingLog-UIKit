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
  // Loading exercises from the Bundle JSON file
  exerciseTypeDB = Bundle.main.decode([ExerciseType].self, from: "exerciseDB.json")
}

// We can use this in v2.0 to add lbs support
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
  // Barbell weights go up from 20kg (empty bar) to 300kg in 2.5kg increments
  for _ in 1...113 {
    weights.append(Float(weightForBarbell))
    weightForBarbell += 2.5
  }
  weightsForEquipmentType[.barbell] = weights
  weights = []
  // Dumbbell weights go up from 1kg to 50kg in 1kg increments
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
