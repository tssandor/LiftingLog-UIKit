//
//  WorkoutsListViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/31.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class WorkoutsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var workoutsTableView: UITableView!
  @IBOutlet weak var noWorkoutsLabel: UILabel!
  
  var selectedWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.workoutsTableView.separatorStyle = .none
    self.title = "LiftingLog"
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.workoutsTableView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    setupExerciseDB()
//    addDummyExercises()
    workouts.reverse()
//    noWorkoutsLabel.isHidden = true
//    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if workouts.count == 0 {
      workoutsTableView.isHidden = true
      noWorkoutsLabel.isHidden = false
    } else {
      workoutsTableView.isHidden = false
      noWorkoutsLabel.isHidden = true
    }
    // We need this reload so it's updated when we come back from adding a new workout
    workoutsTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return workouts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutsListTableViewCell

    let workoutNumber = workouts.count - indexPath.row
    cell.workoutNumberLabel.text = "Workout #\(workoutNumber)"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
    cell.workoutDateLabel.text = dateFormatter.string(from: workouts[indexPath.row].dateTime)
    
    var totalWeight: Float = 0
    for oneExerciseGroup in workouts[indexPath.row].exerciseGroupsInWorkout {
      for oneExercise in oneExerciseGroup.exercises {
        totalWeight = totalWeight + Float(oneExercise.sets * oneExercise.reps) * oneExercise.weight
      }
    }
    
//    var detailsText: String
//    switch workouts[indexPath.row].exerciseGroupsInWorkout.count {
//    case 0:
//      detailsText = "No details for this workout"
//    case 1:
//      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
//    case 2:
//      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
//      detailsText = detailsText + ", "
//      detailsText = detailsText + workouts[indexPath.row].exerciseGroupsInWorkout[1].exerciseType.exerciseName
//    default:
//      detailsText = workouts[indexPath.row].exerciseGroupsInWorkout[0].exerciseType.exerciseName
//      detailsText = detailsText + ", "
//      detailsText = detailsText + workouts[indexPath.row].exerciseGroupsInWorkout[1].exerciseType.exerciseName
//      detailsText = detailsText + ", and \(workouts[indexPath.row].exerciseGroupsInWorkout.count - 2) more exercises"
//    }
    
    cell.workoutDetailsLabel.text = "Total weight moved: \(totalWeight)" + weightUnit
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedWorkout = workouts[indexPath.row]
    performSegue(withIdentifier: "WorkoutDetailSegue", sender: nil)
  }
  
  @IBAction func pressedAddNewWorkout(_ sender: Any) {
    performSegue(withIdentifier: "AddNewWorkoutSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "WorkoutDetailSegue" {
      let workoutDetailTableViewController = segue.destination as! WorkoutDetailViewController
      workoutDetailTableViewController.workoutDisplayed = selectedWorkout
    }
  }
  
}
