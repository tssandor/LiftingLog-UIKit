//
//  WorkoutModel.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

enum Equipment: String, Codable {
  case dumbbell
  case barbell
  // More equipment might be added later
  //case bodyweight
  //case bands
}

struct ExerciseType: Codable {
  let exerciseName: String
  let exerciseCategory: Equipment
}

struct Exercise: Codable {
  let sets: Int
  let reps: Int
  let weight: Float
}

struct ExerciseGroup: Codable {
  var exerciseType: ExerciseType
  var exercises: [Exercise]
}

struct Workout: Codable {
  var dateTime: Date
  var exerciseGroupsInWorkout: [ExerciseGroup]
  var rating: Int
}
