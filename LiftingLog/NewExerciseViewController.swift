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
  
  var setRepWeightPickerData: [[String]] = [[String]]()
  var selectedSets: String = ""
  var selectedReps: String = ""
  var selectedWeight: String = ""
  
//  @IBOutlet weak var setsButton: UIButton!
//  @IBOutlet weak var repsButton: UIButton!
//  @IBOutlet weak var weightButton: UIButton!
//  @IBOutlet weak var exerciseListTableView: UITableView!
  @IBOutlet weak var performedExercisesTableView: UITableView!
  @IBOutlet weak var setRepWeightPicker: UIPickerView!
  @IBOutlet weak var setRepWeightSubview: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSetRepWeightPickerData(forType: "Barbell")
    setRepWeightSubview.isHidden = true
    selectedSets = setRepWeightPickerData[0][0]
    selectedReps = setRepWeightPickerData[1][0]
    selectedWeight = setRepWeightPickerData[2][0]
      
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
    return 40
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
    performedExercisesListCell.performedExerciseListLabel.text = "This is an exercise"
    return performedExercisesListCell
  }
    
  @IBAction func pressedSelectExercise(_ sender: Any) {
    setupSetRepWeightPickerData(forType: "Dumbbell")
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
//    print(newWorkout)
//    newWorkout.exerciseGroupsInWorkout.append(ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Appended from view", exerciseCategory: "Dumbbell")
//    , exercises: [Exercise(sets: 3, reps: 3, weight: 125.5)]))
//    print(newWorkout)
    self.delegate?.childViewControllerResponse(newlyAddedExerciseGroup: ExerciseGroup(exerciseType: ExerciseType(exerciseName: "Appended from view", exerciseCategory: "Dumbbell"), exercises: [Exercise(sets: 3, reps: 3, weight: 125.5)]))
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return setRepWeightPickerData[component].count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return setRepWeightPickerData[component][row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch component {
    case 0:
      selectedSets = setRepWeightPickerData[component][row]
    case 1:
      selectedReps = setRepWeightPickerData[component][row]
    case 2:
      selectedWeight = setRepWeightPickerData[component][row]
    default:
      print("something went horribly wrong :]")
    }
  }

  @IBAction func pressedDiscardButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func pressedSaveButton(_ sender: Any) {
  }
  
  @IBAction func pressedDoneOnSetRepWeight(_ sender: Any) {
    setRepWeightSubview.isHidden = true
    print("\(selectedSets) x \(selectedReps) x \(selectedWeight)")
  }
  
  func setupSetRepWeightPickerData(forType: String) {
    if forType == "Dumbbell" {
      setRepWeightPickerData =
        [["1 sets", "2 sets", "3 sets", "4 sets", "5 sets"],
         ["1 ", "2", "3", "4", "5", "6", "7", "8", "9 reps", "10 reps"],
         ["1", "2", "3", "4", "5", "6", "7", "8", "10", "12 kg"]]
    } else {
      setRepWeightPickerData =
        [["1 sets", "2 sets", "3 sets", "4 sets", "5 sets"],
         ["1 ", "2", "3", "4", "5", "6", "7", "8", "9 reps", "10 reps"],
         ["10", "20", "30", "4", "5", "6", "7", "8", "10", "333 kg"]]
    }
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
