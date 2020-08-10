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
  var selectedSetsArrayIndex: Int = 0
  var selectedRepsArrayIndex: Int = 0
  var selectedWeightArrayIndex: Int = 0
  var selectedExerciseArrayIndex: Int = 0
  var selectedExercise: String = ""
  var equipmentForSelectedExercise: Equipment = .barbell
  // The default exercise type is Deadlift (Barbell), and no exercises yet
  var currentExerciseGroup: ExerciseGroup = ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: .barbell), exercises: [])
  
  var pickerState: PickerState = .selectingExercise
  
//  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var universalPicker: UIPickerView!
  @IBOutlet weak var buttonNavbarSaveExercise: UIBarButtonItem!
  @IBOutlet weak var currentExerciseTableView: UITableView!
  @IBOutlet weak var labelNoSetsYet: UILabel!
  @IBOutlet weak var labelSelectedExercise: UILabel!
  @IBOutlet weak var labelSetRepWeightSelected: UILabel!
  @IBOutlet weak var infolabelSelectExercise: UILabel!
  @IBOutlet weak var infolabelAddSets: UILabel!
  @IBOutlet weak var infolabelSwipeRightToDelete: UILabel!
  @IBOutlet weak var buttonPickerOperator: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDesign()
    resetViewToZero()
  }
  
  func setupDesign() {
    self.title = "New exercise"
    self.currentExerciseTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.universalPicker.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    self.universalPicker.tintColor = .systemIndigo
  }

  func resetViewToZero() {
    // deleting all exercises
    currentExerciseGroup.exercises.removeAll()
    
    // back to the original state
    pickerState = .selectingExercise
    
    // back to the default exercise type of barbell
    equipmentForSelectedExercise = .barbell
    
    // hiding the tableview as there are nothing in it
    self.currentExerciseTableView.isHidden = true
    self.currentExerciseTableView.reloadData()
    self.labelNoSetsYet.isHidden = false
    
    // setting up the navbar
    self.buttonNavbarSaveExercise.isEnabled = false
    
    // setting up the exercise + weight info area
    self.infolabelSelectExercise.isHidden = false
//    self.infoLabelSelectExercise.text = "👈 Select the exercise first"
    self.infolabelAddSets.isHidden = true
    self.labelSetRepWeightSelected.textColor = .lightGray
    self.labelSelectedExercise.textColor = .systemIndigo
    self.labelSelectedExercise.text = "not set"
    self.labelSetRepWeightSelected.text = "not set"

    // setting up the universal picker
    setupSetRepWeightPickerData(forType: .barbell)
    self.universalPicker.reloadAllComponents()
    scrollPickerToDefaultValues()
    
    // updating the button
    refreshPickerOperatorButtonState(nextState: pickerState)
    infolabelSwipeRightToDelete.isHidden = true
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
      labelSelectedExercise.textColor = .lightGray
      infolabelSelectExercise.isHidden = true
      labelSetRepWeightSelected.textColor = .systemIndigo
      labelSelectedExercise.text = "🔒 " + labelSelectedExercise.text!
      infolabelAddSets.isHidden = false
      // we set the selected equpiment so we can display the appropriate weights
      equipmentForSelectedExercise = exerciseTypeDB[selectedExerciseArrayIndex].exerciseCategory
      setupSetRepWeightPickerData(forType: equipmentForSelectedExercise)
      // then we toggle picker to SetsRepsWeight mode
      universalPicker.reloadAllComponents()
      scrollPickerToDefaultValues()
      // then we toggle the picker operator button to the next state
      refreshPickerOperatorButtonState(nextState: pickerState)
    } else {
      // we add these sets to the current exercises
      currentExerciseGroup.exercises.append(Exercise(sets: setsForEquipmentType[equipmentForSelectedExercise]![selectedSetsArrayIndex], reps: repsForEquipmentType[equipmentForSelectedExercise]![selectedRepsArrayIndex], weight: weightsForEquipmentType[equipmentForSelectedExercise]![selectedWeightArrayIndex]))
      // If this is the first exercise the user added, we show the tableview and enable the Save button in the navbar
      if currentExerciseGroup.exercises.count == 1 {
        buttonNavbarSaveExercise.isEnabled = true
        currentExerciseTableView.isHidden = false
        labelNoSetsYet.isHidden = true
      }
      currentExerciseTableView.reloadData()
      infolabelSwipeRightToDelete.isHidden = false
    }
  }
  
  func refreshPickerOperatorButtonState(nextState: PickerState) {
    if nextState == .selectingExercise {
      buttonPickerOperator.setTitle("   Select this exercise   ", for: .normal)
    }
    if nextState == .selectingSets {
      buttonPickerOperator.setTitle("   Add these sets   ", for: .normal)
    }
  }
  
  @IBAction func pressedDiscardButton(_ sender: Any) {
    if currentExerciseGroup.exercises.count == 0 {
      self.navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Watch out!", message: "You've already added some sets to this exercise. Are you sure you want to discard it?", preferredStyle: .alert)
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
    self.delegate?.childViewControllerResponse(newlyAddedExerciseGroup: currentExerciseGroup)
    self.navigationController?.popViewController(animated: true)
  }
  
  // **********************************
  // PICKERVIEW METHODS
  // **********************************
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    // if we are about to display exercise types, we return 1 component
    // for sets-reps-weight we return 3 components
    if pickerState == .selectingExercise {
      return 1
    } else {
      return 3
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    // we configure the number of options in the picker
    if pickerState == .selectingExercise {
      return exerciseTypeDB.count
    } else {
      return setRepWeightStringsForPicker[component].count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if pickerState == .selectingExercise {
      return NSAttributedString(string: exerciseTypeDB[row].exerciseName, attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-DemiBold", size: 16.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
    } else {
      return NSAttributedString(string: setRepWeightStringsForPicker[component][row], attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-DemiBold", size: 16.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
    }
  }
  
//  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    if pickerState == .selectingExercise {
//      return exerciseTypeDB[row].exerciseName
//    } else {
//      return setRepWeightStringsForPicker[component][row]
//    }
//  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerState == .selectingExercise {
      selectedExerciseArrayIndex = row
      labelSelectedExercise.text = exerciseTypeDB[selectedExerciseArrayIndex].exerciseName
    } else {
      if component == 0 { selectedSetsArrayIndex = row } else if component == 1 { selectedRepsArrayIndex = row } else { selectedWeightArrayIndex = row }
      labelSetRepWeightSelected.text = "\(setsForEquipmentType[equipmentForSelectedExercise]![selectedSetsArrayIndex]) x \(repsForEquipmentType[equipmentForSelectedExercise]![selectedRepsArrayIndex]) x \(weightsForEquipmentType[equipmentForSelectedExercise]![selectedWeightArrayIndex])" + weightUnit
    }
  }

  func setupSetRepWeightPickerData(forType: Equipment) {
    let sets: [Int] = setsForEquipmentType[forType]!
    let reps: [Int] = repsForEquipmentType[forType]!
    let weights: [Float] = weightsForEquipmentType[forType]!
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
  
  func scrollPickerToDefaultValues() {
    if pickerState == .selectingExercise {
      var whereDeadliftBarbellIs: Int = 0
      for i in 0...exerciseTypeDB.count {
        if exerciseTypeDB[i].exerciseName == "Deadlift (Barbell)" {
          whereDeadliftBarbellIs = i
          break
        }
      }
      universalPicker.selectRow(whereDeadliftBarbellIs, inComponent: 0, animated: true)
      selectedExerciseArrayIndex = whereDeadliftBarbellIs
      labelSelectedExercise.text = "Deadlift (Barbell)"
    } else {
      universalPicker.selectRow(4, inComponent: 0, animated: false)
      universalPicker.selectRow(4, inComponent: 1, animated: false)
      var whereToScrollWeightPicker: Int = 0
      switch equipmentForSelectedExercise {
      case .barbell:
        // we set it to 60kg
        whereToScrollWeightPicker = 16
      case .dumbbell:
        // we set it to 10kg
        whereToScrollWeightPicker = 11
      }
      universalPicker.selectRow(whereToScrollWeightPicker, inComponent: 2, animated: false)
      selectedRepsArrayIndex = 4
      selectedSetsArrayIndex = 4
      selectedWeightArrayIndex = whereToScrollWeightPicker
      labelSetRepWeightSelected.text = "\(setsForEquipmentType[equipmentForSelectedExercise]![selectedSetsArrayIndex]) x \(repsForEquipmentType[equipmentForSelectedExercise]![selectedRepsArrayIndex]) x \(weightsForEquipmentType[equipmentForSelectedExercise]![selectedWeightArrayIndex])" + weightUnit
    }
  }
  
}
