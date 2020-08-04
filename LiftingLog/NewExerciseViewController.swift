//
//  NewExerciseViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/8/3.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var setsButton: UIButton!
  @IBOutlet weak var repsButton: UIButton!
  @IBOutlet weak var weightButton: UIButton!
  @IBOutlet weak var exerciseListTableView: UITableView!
  @IBOutlet weak var performedExercisesTableView: UITableView!

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == exerciseListTableView {
      return 20
    } else {
      return 100
    }
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
    if tableView == performedExercisesTableView {
      let performedExercisesListCell = tableView.dequeueReusableCell(withIdentifier: "PerformedExercisesListCell", for: indexPath) as! NewExerciseViewPerformedExercisesCell
      performedExercisesListCell.performedExerciseListLabel.text = "second one"
      return performedExercisesListCell
    } else {
      let exerciseListCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseListCell", for: indexPath) as! NewExerciseViewExerciseListCell
      exerciseListCell.exerciseListLabel.text = "first one"
      return exerciseListCell

    }

  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    self.exerciseListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseListCell")
//    self.performedExercisesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PerformedExercisesListCell")

    
    
    let picker = UIPickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(picker)

    picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        // Do any additional setup after loading the view.
    }
    
  @IBAction func pressedAddCustomExercise(_ sender: Any) {
  }
  
  @IBAction func pressedSetsButton(_ sender: Any) {
  }
  
  @IBAction func pressedRepsButton(_ sender: Any) {
  }
  
  @IBAction func pressedWeightButton(_ sender: Any) {
  }
  
  @IBAction func pressedAddExerciseButton(_ sender: Any) {
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 1
  }

  @IBAction func pressedDiscardButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
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
