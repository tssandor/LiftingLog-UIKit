//
//  SetupExerciseDB.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

var exerciseTypeDB: [ExerciseType] = []

var currentWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])
var nextWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])
var newestWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])
var workouts: [Workout] = []

func setupExerciseDB() {
  exerciseTypeDB.append(ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bench Press", exerciseCategory: "Barbell"))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (Barbell)", exerciseCategory: "Barbell"))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Bent Over Row (Dumbbell)", exerciseCategory: "Dumbbell"))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Biceps Curl (Dumbbell)", exerciseCategory: "Dumbbell"))
  exerciseTypeDB.append(ExerciseType(exerciseName: "Arnold Press", exerciseCategory: "Dumbbell"))
}

func addDummyExercises() {
  currentWorkout.dateTime = Date(timeIntervalSince1970: 1596034562)
  
  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Bent Over Row (dumbbell)", exerciseCategory: "Dumbbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120),
         Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  
  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Bench Press", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 5, reps: 5, weight: 60)]
    )
  )

  currentWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Bent Over Row (Barbell)", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 50),
         Exercise(sets: 2, reps: 5, weight: 55.5)]
    )
  )

  nextWorkout.dateTime = Date(timeIntervalSince1970: 1596034962)
  
  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120),
         Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Deadlift", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Bench Press", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 5, reps: 5, weight: 60)]
    )
  )

  nextWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "N Bent Over Row (Barbell)", exerciseCategory: "Barbell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 50),
         Exercise(sets: 2, reps: 5, weight: 55.5)]
    )
  )

  newestWorkout.dateTime = Date(timeIntervalSince1970: 1596035962)
  
  newestWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Kettlebell Swing", exerciseCategory: "Kettlebell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  newestWorkout.exerciseGroupsInWorkout.append(
    ExerciseGroup(
      exerciseType: ExerciseType(exerciseName: "Kettlebell Clean", exerciseCategory: "Kettlebell"),
      exercises:
        [Exercise(sets: 3, reps: 5, weight: 110),
         Exercise(sets: 2, reps: 5, weight: 120)]
    )
  )

  
  workouts.append(currentWorkout)
  workouts.append(nextWorkout)
  workouts.append(newestWorkout)
  
}
