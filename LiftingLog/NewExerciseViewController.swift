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

enum PickerState {
  case selectingExercise
  case selectingSets
}

class NewExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
  
  var delegate: ChildViewControllerDelegate?
  
  var setRepWeightStringsForPicker: [[String]] = [[String]]()
  var selectedSets: Int = 0
  var selectedReps: Int = 0
  var selectedWeight: Float = 0
  var selectedSetsArrayIndex: Int = 0
  var selectedRepsArrayIndex: Int = 0
  var selectedWeightArrayIndex: Int = 0
  var selectedExerciseArrayIndex: Int = 0
  var selectedExercise: String = ""
//  var pickerShowsExercises: Bool = true
//  var exerciseTypeAlreadySet: Bool = false
  var currentExerciseGroup: ExerciseGroup = ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: "Barbell"), exercises: [])
  
  var pickerState: PickerState = .selectingExercise
  
//  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var universalPicker: UIPickerView!
  @IBOutlet weak var buttonNavbarSaveExercise: UIBarButtonItem!
  @IBOutlet weak var currentExerciseTableView: UITableView!
  @IBOutlet weak var labelNoSetsYet: UILabel!
  @IBOutlet weak var exerciseLabel: UILabel!
  @IBOutlet weak var setRepWeightLabel: UILabel!
//  @IBOutlet weak var buttonDeleteAllSets: UIButton!
  @IBOutlet weak var infoLabelSelectExercise: UILabel!
  @IBOutlet weak var infolabelAddSets: UILabel!
  @IBOutlet weak var buttonPickerOperator: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSetRepWeightPickerData(forType: "Barbell")
    selectedSets = setsFor["Barbell"]![4]
    selectedReps = repsFor["Barbell"]![4]
    selectedWeight = weightsFor["Barbell"]![0]
    
    setupDesign()
    resetViewToZero()
  }
  
  func setupDesign() {
    self.title = "New exercise"
    self.currentExerciseTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
  }

  func resetViewToZero() {
    // deleting all exercises
//    currentExerciseGroup.exercises = []
    currentExerciseGroup.exercises.removeAll()
    
    // back to the original state
    pickerState = .selectingExercise
    
    // hiding the tableview as there are nothing in it
    self.currentExerciseTableView.isHidden = true
    self.currentExerciseTableView.reloadData()
    self.labelNoSetsYet.isHidden = false
    
    // setting up the navbar
    self.buttonNavbarSaveExercise.isEnabled = false
    
    // setting up the exercise + weight info area
    self.infoLabelSelectExercise.isHidden = false
//    self.infoLabelSelectExercise.text = "👈 Select the exercise first"
    self.infolabelAddSets.isHidden = true
    self.setRepWeightLabel.textColor = .lightGray
    self.exerciseLabel.textColor = .systemIndigo
    self.exerciseLabel.text = "not set"
    self.setRepWeightLabel.text = "not set"

    // setting up the universal picker
    self.universalPicker.reloadAllComponents()
    
    // setting up the delete all sets button
    refreshPickerOperatorButtonState(nextState: pickerState)
    
    // setting up the delete all sets button
//    self.buttonDeleteAllSets.isEnabled = false
//    self.buttonDeleteAllSets.backgroundColor = .lightGray
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentExerciseGroup.exercises.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let performedExercisesListCell = tableView.dequeueReusableCell(withIdentifier: "PerformedExercisesListCell", for: indexPath) as! NewExerciseViewPerformedExercisesCell
    performedExercisesListCell.performedExerciseListLabel.text =
      "\(currentExerciseGroup.exerciseType.exerciseName) - \(currentExerciseGroup.exercises[indexPath.row].sets) x \(currentExerciseGroup.exercises[indexPath.row].reps) x \(currentExerciseGroup.exercises[indexPath.row].weight)" + weightUnit
    return performedExercisesListCell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      currentExerciseGroup.exercises.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      // If there are no more exercises, we go back to the first state
      if currentExerciseGroup.exercises.count == 0 {
        resetViewToZero()
      }
    }
  }
  
  @IBAction func pressedPickerOperatorButton(_ sender: Any) {
    if pickerState == .selectingExercise {
      // we move to the next state!
      pickerState = .selectingSets
      // we do this if we are selecting an exercise from the picker
      // first we change the exercise type in the current exercise group
      currentExerciseGroup.exerciseType = exerciseTypeDB[selectedExerciseArrayIndex]
      // then we refresh the info area
      exerciseLabel.textColor = .lightGray
      setRepWeightLabel.textColor = .systemIndigo
      exerciseLabel.text = "🔒 " + exerciseLabel.text!
//      infoLabelSelectExercise.text = "👈 Delete sets to change exercise type"
//      infoLabelSelectExercise.isHidden = true
      infolabelAddSets.isHidden = false
      // then we toggle picker to SetsRepsWeight mode
      universalPicker.reloadAllComponents()
      // then we toggle the picker operator button to the next state
      refreshPickerOperatorButtonState(nextState: pickerState)
    } else {
      // we add these sets to the current exercises
      currentExerciseGroup.exercises.append(Exercise(sets: selectedSets, reps: selectedReps, weight: selectedWeight))
      // If this is the first exercise the user added, we show the tableview and enable the Save button in the navbar
      if currentExerciseGroup.exercises.count == 1 {
        buttonNavbarSaveExercise.isEnabled = true
        currentExerciseTableView.isHidden = false
        labelNoSetsYet.isHidden = true
      }
      currentExerciseTableView.reloadData()
      // Enable the delete all sets button
//      buttonDeleteAllSets.isEnabled = true
//      buttonDeleteAllSets.backgroundColor = .systemRed
    }
  }
  
  @IBAction func pressedDeleteAllSets(_ sender: Any) {
    // We clear the current exercises array and reset the interface
//    pickerState = .selectingExercise
//    currentExerciseGroup.exercises = []
    resetViewToZero()
  }
  
  @IBAction func pressedDiscardButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
    self.delegate?.childViewControllerResponse(newlyAddedExerciseGroup: currentExerciseGroup)
    self.navigationController?.popViewController(animated: true)
  }
  
  // **********************************
  // PICKERVIEW METHODS
  // **********************************
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    if pickerState == .selectingExercise {
      return 1
    } else {
      return 3
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerState == .selectingExercise {
      return exerciseTypeDB.count
    } else {
      return setRepWeightStringsForPicker[component].count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerState == .selectingExercise {
      return exerciseTypeDB[row].exerciseName
    } else {
      return setRepWeightStringsForPicker[component][row]
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerState == .selectingExercise {
      selectedExerciseArrayIndex = row
      exerciseLabel.text = exerciseTypeDB[selectedExerciseArrayIndex].exerciseName
    } else {
      // Need to rewrite not to always show barbells
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
      setRepWeightLabel.text = "\(selectedSets) x \(selectedReps) x \(selectedWeight)" + weightUnit
    }
  }

  func setupSetRepWeightPickerData(forType: String) {
    let sets: [Int] = setsFor[forType]!
    let reps: [Int] = repsFor[forType]!
    let weights: [Float] = weightsFor[forType]!
    var setsStrings: [String] = []
    var repsStrings: [String] = []
    var weightsStrings: [String] = []
//    setsStrings.append("not set")
//    repsStrings.append("not set")
//    weightsStrings.append("not set")
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
  
  func setupNothingSelectedAtPicker() {
//    if pickerState == .selectingExercise {
//      var whereDeadliftBarbellIs: Int = 0
//      for i in 0...exerciseTypeDB.count {
//        if exerciseTypeDB[i].exerciseName == "Deadlift (Barbell)" {
//          whereDeadliftBarbellIs = i
//          break
//        }
//      }
//      universalPicker.selectRow(0, inComponent: 0, animated: true)
//      exerciseLabel.text = "not set"
//    } else {
//      universalPicker.selectRow(0, inComponent: 0, animated: false)
//      universalPicker.selectRow(0, inComponent: 1, animated: false)
//      universalPicker.selectRow(0, inComponent: 2, animated: false)
//      setRepWeightLabel.text = "not set"
//    }
  }
  
  func switchToExerciseListViewInPicker() {
    // Set up views
//    pickerState = .selectingExercise
//    selectExerciseTypeButton.isEnabled = false
//    selectExerciseTypeButton.backgroundColor = .lightGray
//    selectSetRepWeightButton.isEnabled = true
//    selectSetRepWeightButton.backgroundColor = .systemGreen
//    universalPicker.reloadAllComponents()
  }
  
  func switchToSetRepWeightListViewInPicker(disableExercisesPicker: Bool) {
    // Set up views
    pickerState = .selectingSets
//    selectSetRepWeightButton.isEnabled = false
//    selectSetRepWeightButton.backgroundColor = .lightGray
    if disableExercisesPicker {
      disableSelectExerciseFeature()
    } else {
      enableSelectExerciseFeature()
    }
    
    // set up data for the picker (depending on the exercise type)
    setupSetRepWeightPickerData(forType: "Barbell")
    universalPicker.reloadAllComponents()
  }
  
  func disableSelectExerciseFeature() {
//    selectExerciseTypeButton.backgroundColor = .systemRed
//    selectExerciseTypeButton.isEnabled = false
  }
  
  func enableSelectExerciseFeature() {
//    if pickerShowsExercises {
//      selectExerciseTypeButton.backgroundColor = .lightGray
//    } else {
//      selectExerciseTypeButton.backgroundColor = .systemGreen
//    }
//    selectExerciseTypeButton.isEnabled = true
  }
  
  func refreshPickerOperatorButtonState(nextState: PickerState) {
//    print(nextState)
    if nextState == .selectingExercise {
      buttonPickerOperator.setTitle("   Select this exercise   ", for: .normal)
    }
    if nextState == .selectingSets {
      buttonPickerOperator.setTitle("   Add these sets   ", for: .normal)
    }
  }

  
}
