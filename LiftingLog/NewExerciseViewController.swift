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
  var selectedSetsArrayIndex: Int = 0
  var selectedRepsArrayIndex: Int = 0
  var selectedWeightArrayIndex: Int = 0
  var selectedExerciseArrayIndex: Int = 0
  var selectedExercise: String = ""
  var pickerShowsExercises: Bool = true
  var currentExerciseGroup: ExerciseGroup = ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: "Barbell"), exercises: [])
  
  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var universalPicker: UIPickerView!
//  @IBOutlet weak var setRepWeightSubview: UIView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var currentExerciseTableView: UITableView!
  @IBOutlet weak var addASetLabel: UILabel!
  @IBOutlet weak var selectExerciseTypeButton: UIButton!
  @IBOutlet weak var selectSetRepWeightButton: UIButton!
  @IBOutlet weak var exerciseLabel: UILabel!
  @IBOutlet weak var setRepWeightLabel: UILabel!
  @IBOutlet weak var deleteAllSetsButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "New exercise in workout"
    setupSetRepWeightPickerData(forType: "Barbell")
    saveButton.isEnabled = false
    selectedSets = setsFor["Barbell"]![4]
    selectedReps = repsFor["Barbell"]![4]
    selectedWeight = weightsFor["Barbell"]![0]
    self.performedExercisesTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    // need to reorg these to functions
    selectExerciseTypeButton.isEnabled = false
    selectExerciseTypeButton.setTitle("🔒", for: .disabled)
    selectExerciseTypeButton.backgroundColor = .lightGray
    selectSetRepWeightButton.isEnabled = true
    selectSetRepWeightButton.backgroundColor = .systemGreen
    deleteAllSetsButton.isEnabled = false
    deleteAllSetsButton.backgroundColor = .lightGray
//    print(exerciseTypeDB)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if currentExerciseGroup.exercises.count == 0 {
      currentExerciseTableView.isHidden = true
      addASetLabel.isHidden = false
    } else {
      currentExerciseTableView.isHidden = false
      addASetLabel.isHidden = true
    }
    if pickerShowsExercises {
      movePickerToInitialPosition()
    } else {
      universalPicker.selectRow(4, inComponent: 0, animated: false)
      universalPicker.selectRow(4, inComponent: 1, animated: false)
    }
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
      
      // If there are no more exercises, we need to re-enable the select exercise feature, switch back to the exercise view in the picker, hide the tableview, and disable the Save button
      if currentExerciseGroup.exercises.count == 0 {
        switchToExerciseListViewInPicker()
        enableSelectExerciseFeature()
//        if pickerShowsExercises {
//          selectExerciseTypeButton.backgroundColor = .lightGray
//        } else {
//          selectExerciseTypeButton.backgroundColor = .systemGreen
//        }
        currentExerciseTableView.isHidden = true
        addASetLabel.isHidden = false
        saveButton.isEnabled = false
      }
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
    
  @IBAction func pressedSelectExercise(_ sender: Any) {
//    selectExerciseTypeButton.isEnabled = false
//    selectExerciseTypeButton.backgroundColor = .lightGray
//    selectSetRepWeightButton.isEnabled = true
//    selectSetRepWeightButton.backgroundColor = .systemGreen
//    pickerShowsExercises = true
    // reloadPicker(pickerShowsExercises)
//    setRepWeightPicker.reloadAllComponents()
    
    // This is just for reference, will change completely
//    setupSetRepWeightPickerData(forType: "Barbell")
//    universalPicker.reloadAllComponents()
//    setRepWeightSubview.isHidden = false
    switchToExerciseListViewInPicker()
  }
  
  @IBAction func pressedSelectSetRepWeight(_ sender: Any) {
//    selectExerciseTypeButton.isEnabled = true
//    selectExerciseTypeButton.backgroundColor = .systemGreen
//    selectSetRepWeightButton.isEnabled = false
//    selectSetRepWeightButton.backgroundColor = .lightGray
//    pickerShowsExercises = false
//    universalPicker.reloadAllComponents()
//    if setRepWeightLabel.text == "not set" {
//      setRepWeightLabel.text = "\(selectedSets) x \(selectedReps) x \(selectedWeight)" + weightUnit
//      universalPicker.selectRow(selectedSets - 1, inComponent: 0, animated: false)
//      universalPicker.selectRow(selectedReps - 1, inComponent: 1, animated: false)
//      setRepWeightPicker.selectRow(selectedWeight, inComponent: 2, animated: false)
//    }
//    universalPicker.reloadAllComponents()
    // reloadPicker(pickerShowsExercises)
    print(currentExerciseGroup.exercises)
    print(currentExerciseGroup.exercises.count)
    if currentExerciseGroup.exercises.count == 0 {
      switchToSetRepWeightListViewInPicker(disableExercisesPicker: false)
    } else {
      switchToSetRepWeightListViewInPicker(disableExercisesPicker: true)
    }
  }
  
  @IBAction func pressedAddExerciseButton(_ sender: Any) {
    // We set the type of the current exercise to the selected one
    currentExerciseGroup.exerciseType = exerciseTypeDB[selectedExerciseArrayIndex]
    // And add the sets
    currentExerciseGroup.exercises.append(Exercise(sets: selectedSets, reps: selectedReps, weight: selectedWeight))
    // If this is the first exercise the user added, we show the tableview and enable the Save button in the navbar
    if currentExerciseGroup.exercises.count == 1 {
      saveButton.isEnabled = true
      currentExerciseTableView.isHidden = false
      addASetLabel.isHidden = true
    }
    
    currentExerciseTableView.reloadData()
    
    // Disable the set exercise button as we already have an exercise in the list
    disableSelectExerciseFeature()
    
    // Enable the delete all sets button
    deleteAllSetsButton.isEnabled = true
    deleteAllSetsButton.backgroundColor = .systemRed
  }
  
  @IBAction func pressedDeleteAllSets(_ sender: Any) {
    // We clear the current exercises array and set up the view accordingly (no tableview, no save button)
    currentExerciseGroup.exercises = []
    currentExerciseTableView.isHidden = true
    addASetLabel.isHidden = false
    saveButton.isEnabled = false
    performedExercisesTableView.reloadData()
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
    if pickerShowsExercises {
      return 1
    } else {
      return 3
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerShowsExercises {
      return exerciseTypeDB.count
    } else {
      return setRepWeightStringsForPicker[component].count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerShowsExercises {
      return exerciseTypeDB[row].exerciseName
    } else {
      return setRepWeightStringsForPicker[component][row]
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerShowsExercises {
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
  
  func movePickerToInitialPosition() {
    // For the exercise type picker, the initial position is "Deadlift (Barbell)" as the most common exercise
    if pickerShowsExercises {
      var whereDeadliftBarbellIs: Int = 0
      for i in 0...exerciseTypeDB.count {
        if exerciseTypeDB[i].exerciseName == "Deadlift (Barbell)" {
          whereDeadliftBarbellIs = i
          break
        }
      }
      universalPicker.selectRow(whereDeadliftBarbellIs, inComponent: 0, animated: true)
      exerciseLabel.text = exerciseTypeDB[whereDeadliftBarbellIs].exerciseName
    } else {
    // For the SetRepWeight picker, the initial position is 5 sets x 5 reps x lowest weight for the exercise category
      
    }
  }
  
  func switchToExerciseListViewInPicker() {
    // Set up views
    pickerShowsExercises = true
    selectExerciseTypeButton.isEnabled = false
    selectExerciseTypeButton.backgroundColor = .lightGray
    selectSetRepWeightButton.isEnabled = true
    selectSetRepWeightButton.backgroundColor = .systemGreen
    universalPicker.reloadAllComponents()
  }
  
  func switchToSetRepWeightListViewInPicker(disableExercisesPicker: Bool) {
    // Set up views
    pickerShowsExercises = false
    selectSetRepWeightButton.isEnabled = false
    selectSetRepWeightButton.backgroundColor = .lightGray
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
    selectExerciseTypeButton.backgroundColor = .systemRed
    selectExerciseTypeButton.isEnabled = false
  }
  
  func enableSelectExerciseFeature() {
    if pickerShowsExercises {
      selectExerciseTypeButton.backgroundColor = .lightGray
    } else {
      selectExerciseTypeButton.backgroundColor = .systemGreen
    }
    selectExerciseTypeButton.isEnabled = true
  }

  
}
