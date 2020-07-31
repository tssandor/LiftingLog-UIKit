//
//  WorkoutsListViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/31.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class WorkoutsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorStyle = .none
    setupExerciseDB()
    addDummyExercises()
    workouts.reverse()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return workouts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutTableViewCell

    let workoutNumber = workouts.count - indexPath.row
    cell.workoutNumberLabel.text = "Workout #\(workoutNumber)"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
    cell.workoutDateLabel.text = dateFormatter.string(from: workouts[indexPath.row].dateTime)
    
    var detailsText: String
    switch workouts[indexPath.row].exerciseGroupsInWorkout.count {
    case 0:
      detailsText = "No details for this workout"
    case 1:
      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
    case 2:
      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
      detailsText = detailsText + ", "
      detailsText = detailsText + workouts[indexPath.row].exerciseGroupsInWorkout[1].exerciseType.exerciseName
    default:
      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
      detailsText = detailsText + ", "
      detailsText = detailsText + workouts[indexPath.row].exerciseGroupsInWorkout[1].exerciseType.exerciseName
      detailsText = detailsText + ", and \(workouts[indexPath.row].exerciseGroupsInWorkout.count - 2) more exercises"
    }
    
    cell.workoutDetailsLabel.text = detailsText
      
    return cell
  }
  
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
