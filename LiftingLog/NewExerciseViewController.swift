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
  
//  @IBOutlet weak var setsButton: UIButton!
//  @IBOutlet weak var repsButton: UIButton!
//  @IBOutlet weak var weightButton: UIButton!
//  @IBOutlet weak var exerciseListTableView: UITableView!
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
      
  //    self.exerciseListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseListCell")
  //    self.performedExercisesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PerformedExercisesListCell")

      
      
  //    let picker = UIPickerView()
  //    picker.translatesAutoresizingMaskIntoConstraints = false
  //    view.addSubview(picker)
  //
  //    picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
  //    picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
  //    picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

          // Do any additional setup after loading the view.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentExerciseGroup.exercises.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if tableView == exerciseListTableView {
//      let exerciseListCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseListCell", for: indexPath) as! NewExerciseViewExerciseListCell
//      exerciseListCell.exerciseListLabel.text = "first one"
//      return exerciseListCell
//    } else {
//      let performedExercisesListCell = tableView.dequeueReusableCell(withIdentifier: "PerformedExercisesListCell", for: indexPath) as! NewExerciseViewPerformedExercisesCell
//      performedExercisesListCell.performedExerciseListLabel.text = "second one"
//      return performedExercisesListCell
//    }
    let performedExercisesListCell = tableView.dequeueReusableCell(withIdentifier: "PerformedExercisesListCell", for: indexPath) as! NewExerciseViewPerformedExercisesCell
    performedExercisesListCell.performedExerciseListLabel.text = "\(currentExerciseGroup.exercises[indexPath.row].sets) x \(currentExerciseGroup.exercises[indexPath.row].reps) x \(currentExerciseGroup.exercises[indexPath.row].weight)" + weightUnit
    return performedExercisesListCell
  }
    
  @IBAction func pressedSelectExercise(_ sender: Any) {
    setupSetRepWeightPickerData(forType: "Barbell")
    setRepWeightPicker.reloadAllComponents()
//      let picker = UIPickerView()
//      picker.translatesAutoresizingMaskIntoConstraints = false
//      view.addSubview(picker)
//
//      picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//      picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//      picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
////    picker.center = self.view.center
//    picker.dataSource = self
//    picker.delegate = self
//    picker.backgroundColor = .white
//    picker.tintColor = .red
    setRepWeightSubview.isHidden = false

  }
  
  @IBAction func pressedAddExerciseButton(_ sender: Any) {
    currentExerciseGroup.exercises.append(Exercise(sets: selectedSets, reps: selectedReps, weight: selectedWeight))
    saveButton.isEnabled = true
    currentExerciseTableView.reloadData()
    
    
//    print(newWorkout)
//    newWorkout.exerciseGroupsInWorkout.append(ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Appended from view", exerciseCategory: "Dumbbell")
//    , exercises: [Exercise(sets: 3, reps: 3, weight: 125.5)]))
//    print(newWorkout)
  }
  
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

  @IBAction func pressedDiscardButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
    self.delegate?.childViewControllerResponse(newlyAddedExerciseGroup: currentExerciseGroup)
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedDoneOnSetRepWeight(_ sender: Any) {
    setRepWeightSubview.isHidden = true
//    print("\(selectedSets) x \(selectedReps) x \(selectedWeight)")
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
    
    
//    for rep in repsFor(forType: "Barbell").count {
      
//    }
//    setRepWeightStringsForPicker =
//      [["1 sets", "2 sets", "3 sets", "4 sets", "5 sets"],
//       ["1 sets", "2 sets", "3 sets", "4 sets", "5 sets", "6 sets", "7 sets", "8 sets", "9 reps", "10 reps"],
//       ["1", "2", "3", "4", "5", "6", "7", "8", "10", "12 kg"]]
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
