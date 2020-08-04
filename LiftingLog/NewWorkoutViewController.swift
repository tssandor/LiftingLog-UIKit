//
//  NewWorkoutViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChildViewControllerDelegate {
 
  func childViewControllerResponse(newlyAddedExerciseGroup: ExerciseGroup) {
    newWorkout.exerciseGroupsInWorkout.reverse()
    newWorkout.exerciseGroupsInWorkout.append(newlyAddedExerciseGroup)
    newWorkout.exerciseGroupsInWorkout.reverse()
    saveButton.isEnabled = true
  }
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var noExercisesLabel: UILabel!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var newWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "New Workout #\(workouts.count+1)"
    self.tableView.separatorStyle = .none
    newWorkout.exerciseGroupsInWorkout.reverse()
    saveButton.isEnabled = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if newWorkout.exerciseGroupsInWorkout.count == 0 {
      self.tableView.isHidden = true
      self.noExercisesLabel.isHidden = false
    } else {
      self.tableView.isHidden = false
      self.noExercisesLabel.isHidden = true
      self.tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newWorkout.exerciseGroupsInWorkout.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseGroupCell", for: indexPath) as! NewWorkoutTableViewCell

    cell.exerciseCategoryLabel.text = newWorkout.exerciseGroupsInWorkout[indexPath.row].exerciseType.exerciseCategory
    cell.exerciseNameLabel.text = newWorkout.exerciseGroupsInWorkout[indexPath.row].exerciseType.exerciseName

    var setsDetails: String = ""
    
    for i in 0...newWorkout.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
      let sets = newWorkout.exerciseGroupsInWorkout[indexPath.row].exercises[i]
      if i == newWorkout.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit)
      } else {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit + "\n")
      }
    }
    cell.setsMultilineLabel.text = setsDetails

    return cell
  }
  
  @IBAction func pressedAddNewExerciseButton(_ sender: Any) {
    let goNext = storyboard!.instantiateViewController(withIdentifier: "NewExerciseVewController") as! NewExerciseViewController
    // This is important for passing data back to here later
    goNext.delegate = self
    self.navigationController?.pushViewController(goNext, animated: true)
  }

  @IBAction func pressedCancelButton(_ sender: Any) {
    if newWorkout.exerciseGroupsInWorkout.count == 0 {
      self.navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Watch out!", message: "This workout is not empty. Are you sure you want to discard it?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
          self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
          print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
    workouts.reverse()
    workouts.append(newWorkout)
    workouts.reverse()
    print(workouts)
    self.navigationController?.popViewController(animated: true)
  }
}
