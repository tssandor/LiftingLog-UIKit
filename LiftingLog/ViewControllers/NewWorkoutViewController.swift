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
    currentWorkout.exerciseGroupsInWorkout.reverse()
    currentWorkout.exerciseGroupsInWorkout.append(newlyAddedExerciseGroup)
    currentWorkout.exerciseGroupsInWorkout.reverse()
    saveButton.isEnabled = true
  }
  
  @IBOutlet var exerciseGroupsTableView: UITableView!
  @IBOutlet weak var noExercisesLabel: UILabel!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  let itsANewWorkout = -1
  var currentWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [], rating: 3)
  var workoutReceivedFromPreviousController: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [], rating: 3)
  var indexOfWorkoutBeingEdited: Int = -1

  override func viewDidLoad() {
    super.viewDidLoad()
    if indexOfWorkoutBeingEdited > itsANewWorkout {
      currentWorkout = workoutReceivedFromPreviousController
    } else {
      indexOfWorkoutBeingEdited = itsANewWorkout
    }
    setupDesign()
    currentWorkout.exerciseGroupsInWorkout.reverse()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if currentWorkout.exerciseGroupsInWorkout.count == 0 {
      self.exerciseGroupsTableView.isHidden = true
      self.noExercisesLabel.isHidden = false
    } else {
      self.exerciseGroupsTableView.isHidden = false
      self.noExercisesLabel.isHidden = true
      self.exerciseGroupsTableView.reloadData()
    }
    exerciseGroupsTableView.scroll(to: .top, animated: true)
  }
  
  func setupDesign() {
    if indexOfWorkoutBeingEdited == itsANewWorkout {
      self.title = "New Workout #\(workouts.count+1)"
    } else {
      self.title = "Editing Workout #\(workouts.count-indexOfWorkoutBeingEdited)"
    }
    self.exerciseGroupsTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.exerciseGroupsTableView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    resetViewToZero()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentWorkout.exerciseGroupsInWorkout.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseGroupCell", for: indexPath) as! NewWorkoutTableViewCell
    cell.exerciseNameLabel.text = currentWorkout.exerciseGroupsInWorkout[indexPath.row].exerciseType.exerciseName

    var setsDetails: String = ""
    
    for i in 0...currentWorkout.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
      let sets = currentWorkout.exerciseGroupsInWorkout[indexPath.row].exercises[i]
      if i == currentWorkout.exerciseGroupsInWorkout[indexPath.row].exercises.count-1 {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit)
      } else {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)" + weightUnit + "\n")
      }
    }
    cell.setsMultilineLabel.text = setsDetails

    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      currentWorkout.exerciseGroupsInWorkout.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      saveButton.isEnabled = true
      // If there are no more exercise groups, we go back to the first state
      if currentWorkout.exerciseGroupsInWorkout.count == 0 {
        resetViewToZero()
      }
    }
  }
  
  @IBAction func pressedAddNewExerciseButton(_ sender: Any) {
    let goNext = storyboard!.instantiateViewController(withIdentifier: "NewExerciseVewController") as! NewExerciseViewController
    // This is important for passing data back to here later
    goNext.delegate = self
    self.navigationController?.pushViewController(goNext, animated: true)
  }

  @IBAction func pressedDiscardButton(_ sender: Any) {
    if currentWorkout.exerciseGroupsInWorkout.count == 0 || !saveButton.isEnabled {
      self.navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Watch out!", message: "This workout was modified. Are you sure you want to discard it?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
          self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
    // We ask the user to rate the workout
    // This method will handle everything else in the chain, too
    askForRating()
  }
    
  func askForRating() {
    let optionMenu = UIAlertController(title: nil, message: "💪 How was your workout?", preferredStyle: .actionSheet)
    let stars5 = UIAlertAction(title: "Amazing ⭐️⭐️⭐️⭐️⭐️", style: .default)  { (action:UIAlertAction!) in
      self.currentWorkout.rating = 5
      self.saveDataAndDismissView()
    }
    let stars4 = UIAlertAction(title: "Good ⭐️⭐️⭐️⭐️⚪️", style: .default)  { (action:UIAlertAction!) in
      self.currentWorkout.rating = 4
      self.saveDataAndDismissView()
    }
    let stars3 = UIAlertAction(title: "Meh ⭐️⭐️⭐️⚪️⚪️", style: .default)  { (action:UIAlertAction!) in
      self.currentWorkout.rating = 3
      self.saveDataAndDismissView()
    }
    let stars2 = UIAlertAction(title: "Quite bad ⭐️⭐️⚪️⚪️⚪️", style: .default)  { (action:UIAlertAction!) in
      self.currentWorkout.rating = 2
      self.saveDataAndDismissView()
    }
    let stars1 = UIAlertAction(title: "Terrible ⭐️⚪️⚪️⚪️⚪️", style: .default)  { (action:UIAlertAction!) in
      self.currentWorkout.rating = 1
      self.saveDataAndDismissView()
    }
    optionMenu.addAction(stars5)
    optionMenu.addAction(stars4)
    optionMenu.addAction(stars3)
    optionMenu.addAction(stars2)
    optionMenu.addAction(stars1)
    self.present(optionMenu, animated: true, completion: nil)
  }
  
  func saveDataAndDismissView() {
    if indexOfWorkoutBeingEdited > itsANewWorkout {
       let difference = calculateTotalWeightInWorkout(in: currentWorkout) - calculateTotalWeightInWorkout(in: workouts[indexOfWorkoutBeingEdited])
       updateTotalWeightOnServer(with: difference)
       workouts[indexOfWorkoutBeingEdited] = currentWorkout
       saveWorkoutsToJSON()
       navigationController?.popViewController(animated: true)
     } else {
       workouts.reverse()
       workouts.append(currentWorkout)
       workouts.reverse()
       let difference = calculateTotalWeightInWorkout(in: currentWorkout)
       updateTotalWeightOnServer(with: difference)
       saveWorkoutsToJSON()
       navigationController?.popViewController(animated: true)
     }
  }
  
  func resetViewToZero() {
    saveButton.isEnabled = false
    self.exerciseGroupsTableView.isHidden = true
    self.noExercisesLabel.isHidden = false
  }
  
}

