//
//  WorkoutDetailViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/31.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  
  var workoutDisplayed: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [], rating: 5)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
    self.title = dateFormatter.string(from: workoutDisplayed.dateTime)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return workoutDisplayed.exerciseGroupsInWorkout.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutDetailCell", for: indexPath) as! WorkoutDetailTableViewCell

    cell.exerciseCategoryLabel.text = workoutDisplayed.exerciseGroupsInWorkout[indexPath.row].exerciseType.exerciseCategory.rawValue
    cell.exerciseNameLabel.text = workoutDisplayed.exerciseGroupsInWorkout[indexPath.row].exerciseType.exerciseName

    var setsDetails: String = ""
    
    for i in 0...workoutDisplayed.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
      let sets = workoutDisplayed.exerciseGroupsInWorkout[indexPath.row].exercises[i]
      if i == workoutDisplayed.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit)
      } else {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit + "\n")
      }
    }
    cell.setsMultilineLabel.text = setsDetails

    return cell
  }
  
}
