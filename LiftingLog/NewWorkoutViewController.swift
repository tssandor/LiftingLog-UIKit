//
//  NewWorkoutViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var noExercisesLabel: UILabel!
  
  var newWorkout: Workout = Workout(dateTime: Date(), exerciseGroupsInWorkout: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "New Workout #\(workouts.count+1)"
    self.tableView.separatorStyle = .none
//    setupExerciseDB()
//    addDummyExercises()
    newWorkout.exerciseGroupsInWorkout.reverse()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if newWorkout.exerciseGroupsInWorkout.count == 0 {
      self.tableView.isHidden = true
      self.noExercisesLabel.isHidden = false
      print("none")
    } else {
      self.tableView.isHidden = false
      self.noExercisesLabel.isHidden = true
      self.tableView.reloadData()
      print(newWorkout)
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
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)")
      } else {
        setsDetails.append("\(sets.sets) x \(sets.reps) x \(sets.weight)\n")
      }
    }
    cell.setsMultilineLabel.text = setsDetails

    return cell
  }
  
  @IBAction func pressedAddNewExerciseButton(_ sender: Any) {
    performSegue(withIdentifier: "AddNewExerciseSegue", sender: nil)
//    self.tableView.isHidden = false
//    self.noExercisesLabel.isHidden = true
//    newWorkout.exerciseGroupsInWorkout.reverse()
//    newWorkout.exerciseGroupsInWorkout.append(
//       ExerciseGroup(
//         exerciseType: ExerciseType(exerciseName: "Appended", exerciseCategory: "Barbell"),
//         exercises:
//           [Exercise(sets: 3, reps: 5, weight: 110),
//            Exercise(sets: 2, reps: 5, weight: 120),
//            Exercise(sets: 3, reps: 5, weight: 110),
//            Exercise(sets: 2, reps: 5, weight: 120)]
//       )
//     )
//    newWorkout.exerciseGroupsInWorkout.reverse()
//    self.tableView.reloadData()
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
//    If you pushed the viewController you use self.navigationController?.popViewController(animated: true)
//
//    If you presented it modally you use self.dismiss(self, animated: true)
//
//    When its presented from a modal segue you use self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
}


//
//extension String {
//    enum TruncationPosition {
//        case head
//        case middle
//        case tail
//    }
//
//    func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
//        guard self.count > limit else { return self }
//
//        switch position {
//        case .head:
//            return leader + self.suffix(limit)
//        case .middle:
//            let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))
//
//            let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
//            
//            return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
//        case .tail:
//            return self.prefix(limit) + leader
//        }
//    }
//}
