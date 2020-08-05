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
  var selectedExercise: String = ""
//  var activeDropdownEmoji: String = "     ↘️     "
//  var inactiveDropdownEmoji: String = "     ➡️     "
  var pickerShowsExercises: Bool = true
  var currentExerciseGroup: ExerciseGroup = ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Deadlift (Barbell)", exerciseCategory: "Barbell"), exercises: [])
  
  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var setRepWeightPicker: UIPickerView!
//  @IBOutlet weak var setRepWeightSubview: UIView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var currentExerciseTableView: UITableView!
  @IBOutlet weak var addASetLabel: UILabel!
  @IBOutlet weak var selectExerciseTypeButton: UIButton!
  @IBOutlet weak var selectSetRepWeightButton: UIButton!
  @IBOutlet weak var exerciseLabel: UILabel!
  @IBOutlet weak var setRepWeightLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSetRepWeightPickerData(forType: "Barbell")
    saveButton.isEnabled = false
    selectedSets = setsFor["Barbell"]![4]
    selectedReps = repsFor["Barbell"]![4]
    selectedWeight = weightsFor["Barbell"]![0]
    self.performedExercisesTableView.separatorStyle = .none
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    // need to reorg these to functions
    selectExerciseTypeButton.isEnabled = false
    selectExerciseTypeButton.backgroundColor = .lightGray
    selectSetRepWeightButton.isEnabled = true
    selectSetRepWeightButton.backgroundColor = .systemGreen
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
      
    } else {
      setRepWeightPicker.selectRow(4, inComponent: 0, animated: false)
      setRepWeightPicker.selectRow(4, inComponent: 1, animated: false)
    }
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
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      currentExerciseGroup.exercises.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      if currentExerciseGroup.exercises.count == 0 {
        currentExerciseTableView.isHidden = true
        addASetLabel.isHidden = false
        saveButton.isEnabled = false
      }
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
    
  @IBAction func pressedSelectExercise(_ sender: Any) {
    selectExerciseTypeButton.isEnabled = false
    selectExerciseTypeButton.backgroundColor = .lightGray
    selectSetRepWeightButton.isEnabled = true
    selectSetRepWeightButton.backgroundColor = .systemGreen
    pickerShowsExercises = true
    // reloadPicker(pickerShowsExercises)
//    setRepWeightPicker.reloadAllComponents()
    
    // This is just for reference, will change completely
    setupSetRepWeightPickerData(forType: "Barbell")
    setRepWeightPicker.reloadAllComponents()
//    setRepWeightSubview.isHidden = false
  }
  
  @IBAction func pressedSelectSetRepWeight(_ sender: Any) {
    selectExerciseTypeButton.isEnabled = true
    selectExerciseTypeButton.backgroundColor = .systemGreen
    selectSetRepWeightButton.isEnabled = false
    selectSetRepWeightButton.backgroundColor = .lightGray
    pickerShowsExercises = false
    setRepWeightPicker.reloadAllComponents()
    if setRepWeightLabel.text == "not set" {
      setRepWeightLabel.text = "\(selectedSets) x \(selectedReps) x \(selectedWeight)" + weightUnit
      setRepWeightPicker.selectRow(4, inComponent: 0, animated: false)
      setRepWeightPicker.selectRow(4, inComponent: 1, animated: false)
    }
    setRepWeightPicker.reloadAllComponents()
    // reloadPicker(pickerShowsExercises)
  }
  
  @IBAction func pressedAddExerciseButton(_ sender: Any) {
    currentExerciseGroup.exercises.append(Exercise(sets: selectedSets, reps: selectedReps, weight: selectedWeight))
    saveButton.isEnabled = true
    currentExerciseTableView.isHidden = false
    addASetLabel.isHidden = true
    currentExerciseTableView.reloadData()
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
//      print(exerciseTypeDB.count)
      return exerciseTypeDB.count
    } else {
      return setRepWeightStringsForPicker[component].count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerShowsExercises {
//      print(exerciseTypeDB[0].exerciseName)
//      print(exerciseTypeDB[1].exerciseName)
//      print(exerciseTypeDB[2].exerciseName)
//      print(exerciseTypeDB[3].exerciseName)
//      print(exerciseTypeDB[4].exerciseName)
//      print(exerciseTypeDB[5].exerciseName)
      return exerciseTypeDB[row].exerciseName
    } else {
      return setRepWeightStringsForPicker[component][row]
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerShowsExercises {
      exerciseLabel.text = exerciseTypeDB[row].exerciseName
    } else {
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
  
}
