//
//  NewExerciseViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/8/3.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

protocol ChildViewControllerDelegate
{
  func childViewControllerResponse(newlyAddedExerciseGroup: ExerciseGroup)
}

class NewExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
  
  var delegate: ChildViewControllerDelegate?
  
  var setRepWeightStringsForPicker: [[String]] = [[String]]()
  var selectedSets: Int = 0
  var selectedReps: Int = 0
  var selectedWeight: Float = 0
  var currentExerciseGroup: ExerciseGroup = ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: "Barbell"), exercises: [])
  
  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var setRepWeightPicker: UIPickerView!
  @IBOutlet weak var setRepWeightSubview: UIView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var currentExerciseTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSetRepWeightPickerData(forType: "Barbell")
    setRepWeightSubview.isHidden = true
    saveButton.isEnabled = false
    selectedSets = setsFor["Barbell"]![0]
    selectedReps = repsFor["Barbell"]![0]
    selectedWeight = weightsFor["Barbell"]![0]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentExerciseGroup.exercises.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let performedExercisesListCell = tableView.dequeueReusableCell(withIdentifier: "PerformedExercisesListCell", for: indexPath) as! NewExerciseViewPerformedExercisesCell
    performedExercisesListCell.performedExerciseListLabel.text =
      "\(currentExerciseGroup.exercises[indexPath.row].sets) x \(currentExerciseGroup.exercises[indexPath.row].reps) x \(currentExerciseGroup.exercises[indexPath.row].weight)" + weightUnit
    return performedExercisesListCell
  }
    
  @IBAction func pressedSelectExercise(_ sender: Any) {
    // This is just for reference, will change completely
    setupSetRepWeightPickerData(forType: "Barbell")
    setRepWeightPicker.reloadAllComponents()
    setRepWeightSubview.isHidden = false
  }
  
  @IBAction func pressedAddExerciseButton(_ sender: Any) {
    currentExerciseGroup.exercises.append(Exercise(sets: selectedSets, reps: selectedReps, weight: selectedWeight))
    saveButton.isEnabled = true
    currentExerciseTableView.reloadData()
  }

  @IBAction func pressedDiscardButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
    self.delegate?.childViewControllerResponse(newlyAddedExerciseGroup: currentExerciseGroup)
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedDoneOnSetRepWeight(_ sender: Any) {
//    setRepWeightSubview.isHidden = true
  }
  
  // **********************************
  // PICKERVIEW METHODS
  // **********************************
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return setRepWeightStringsForPicker[component].count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return setRepWeightStringsForPicker[component][row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch component {
    case 0:
      selectedSets = setsFor["Barbell"]![row]
    case 1:
      selectedReps = repsFor["Barbell"]![row]
    case 2:
      selectedWeight = weightsFor["Barbell"]![row]
    default:
      print("something went horribly wrong :]")
    }
  }

  func setupSetRepWeightPickerData(forType: String) {
    let sets: [Int] = setsFor[forType]!
    let reps: [Int] = repsFor[forType]!
    let weights: [Float] = weightsFor[forType]!
    var setsStrings: [String] = []
    var repsStrings: [String] = []
    var weightsStrings: [String] = []
    for set in sets {
      setsStrings.append("\(set) sets")
    }
    for rep in reps {
      repsStrings.append("\(rep) reps")
    }
    for weight in weights {
      weightsStrings.append("\(weight) " + weightUnit)
    }
    setRepWeightStringsForPicker = []
    setRepWeightStringsForPicker.append(setsStrings)
    setRepWeightStringsForPicker.append(repsStrings)
    setRepWeightStringsForPicker.append(weightsStrings)
  }
  
}
