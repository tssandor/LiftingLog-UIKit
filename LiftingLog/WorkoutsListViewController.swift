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
  @IBOutlet weak var noWorkoutsLabel: UILabel!
  
  var selectedWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorStyle = .none
    self.title = "LiftingLog"
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.tableView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    setupExerciseDB()
    addDummyExercises()
    workouts.reverse()
    noWorkoutsLabel.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if workouts.count == 0 {
      tableView.isHidden = true
      noWorkoutsLabel.isHidden = false
    }
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedWorkout = workouts[indexPath.row]
    performSegue(withIdentifier: "WorkoutDetailSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "WorkoutDetailSegue" {
      let workoutDetailTableViewController = segue.destination as! WorkoutDetailViewController
      workoutDetailTableViewController.workoutDisplayed = selectedWorkout
    }
  }
  
  @IBAction func pressedAddNewWorkout(_ sender: Any) {
//    tableView.isHidden = false
//    noWorkoutsLabel.isHidden = true
//    workouts.reverse()
//    workouts.append(currentWorkout)
//    workouts.reverse()
//    self.tableView.reloadData()
    performSegue(withIdentifier: "AddNewWorkoutSegue", sender: nil)
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
