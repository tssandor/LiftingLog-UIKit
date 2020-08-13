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
  @IBOutlet weak var labelTotalWeight: UILabel!
  
  let itsANewWorkout = -1
  var selectedWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [], rating: 3)
  var indexOfWorkoutBeingEdited: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDesign()
    _ = loadWorkoutsFromJSON()
    indexOfWorkoutBeingEdited = itsANewWorkout
    setupExerciseDB()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateTotalWeightFromAPI()
    if workouts.count == 0 {
      workoutsTableView.isHidden = true
      noWorkoutsLabel.isHidden = false
    } else {
      workoutsTableView.isHidden = false
      noWorkoutsLabel.isHidden = true
    }
    // We need this reload so it's updated when we come back from adding a new workout
    workoutsTableView.reloadData()
    workoutsTableView.scroll(to: .top, animated: true)
  }
  
  func setupDesign() {
    labelTotalWeight.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.title = "LiftingLog"
    self.workoutsTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.workoutsTableView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
  }
  
  func updateTotalWeightFromAPI() {
    Networking.sharedInstance.readTotalWeightFromAPI() { (totalWeight) in
       DispatchQueue.main.async {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:totalWeight))
        self.labelTotalWeight.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 15.0)
        self.labelTotalWeight.text = "Did you know?\nFellow lifters moved \(formattedNumber!) \(weightUnit) to date!"
       }
     }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return workouts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutsListTableViewCell
    var stars: String = ""
    for i in 1...5 {
      if i <= workouts[indexPath.row].rating {
        stars = stars + "⭐️"
      } else {
        stars = stars + "⚪️"
      }
    }
    cell.workoutStarsLabel.text = stars
    let workoutNumber = workouts.count - indexPath.row
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
    let dateString = dateFormatter.string(from: workouts[indexPath.row].dateTime)
    cell.workoutNumberAndDateLabel.text = "Workout #\(workoutNumber) (\(dateString))"
    
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
    
    var totalWeight: Float = 0
    for oneExerciseGroup in workouts[indexPath.row].exerciseGroupsInWorkout {
      for oneExercise in oneExerciseGroup.exercises {
        totalWeight = totalWeight + Float(oneExercise.sets * oneExercise.reps) * oneExercise.weight
      }
    }
    detailsText = detailsText + "\nTotal weight moved: \(totalWeight)" + weightUnit

    cell.workoutDetailsLabel.text = detailsText
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let difference = 0 - calculateTotalWeightInWorkout(in: workouts[indexPath.row])
      updateTotalWeightOnServer(with: difference)
      workouts.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.reloadData()
      saveWorkoutsToJSON()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // we need this part so in dark mode the selected cell is still light gray
//    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutsListTableViewCell
//    var viewToSetUpLightGrayBGColor = UIView()
//    viewToSetUpLightGrayBGColor.backgroundColor = UIColor.lightGray
//    cell.selectedBackgroundView = viewToSetUpLightGrayBGColor
//    cell.selectionStyle =
    
    indexOfWorkoutBeingEdited = indexPath.row
    selectedWorkout = workouts[indexOfWorkoutBeingEdited]
    performSegue(withIdentifier: "AddNewWorkoutSegue", sender: nil)
  }
  
  @IBAction func pressedAddNewWorkout(_ sender: Any) {
    selectedWorkout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [], rating: 3)
    indexOfWorkoutBeingEdited = itsANewWorkout
    performSegue(withIdentifier: "AddNewWorkoutSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddNewWorkoutSegue" {
      let newWorkoutTableViewController = segue.destination as! NewWorkoutViewController
      newWorkoutTableViewController.workoutReceivedFromPreviousController = selectedWorkout
      newWorkoutTableViewController.indexOfWorkoutBeingEdited = indexOfWorkoutBeingEdited
    }
  }
  
}
