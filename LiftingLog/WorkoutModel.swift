//
//  WorkoutModel.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

var weightUnit: String = "kg"

//enum Equipment {
//  case dumbbell
//  case barbell
//  case bodyweight
//  case bands
//}

struct ExerciseType: Decodable {
  let exerciseName: String
//  let exerciseCategory: Equipment
  let exerciseCategory: String
}

struct Exercise {
//  let exercise: ExerciseType
  let sets: Int
  let reps: Int
  let weight: Float
}

struct ExerciseGroup {
  let exerciseType: ExerciseType
  let exercises: [Exercise]
}

struct Workout {
  var dateTime: Date
  var exerciseGroupsInWorkout: [ExerciseGroup]
}
