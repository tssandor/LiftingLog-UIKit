//
//  SettingsViewController.swift
//  LiftingLog
//
//  Created by TSS on 2020/8/11.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupDesign()
  }
  
  func setupDesign() {
    self.title = "Settings"
    self.view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
  }
  
  @IBAction func pressedGoToGitHub(_ sender: Any) {
    guard let url = URL(string: "https://github.com/tssandor/LiftingLog-UIKit") else { return }
    UIApplication.shared.open(url)
  }
  
  @IBAction func pressedGoToRW(_ sender: Any) {
    guard let url = URL(string: "https://www.raywenderlich.com") else { return }
    UIApplication.shared.open(url)
  }
  
  @IBAction func pressedDeleteAllWorkouts(_ sender: Any) {
      let alertController = UIAlertController(title: "Danger zone!", message: "You are about to delete your whole workout database. There is NO WAY to undo this. Are you sure?", preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "Delete all", style: .default) { (action:UIAlertAction!) in
        workouts = []
        saveWorkoutsToJSON()
        self.navigationController?.popViewController(animated: true)
      }
      alertController.addAction(OKAction)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
      }
      alertController.addAction(cancelAction)
      self.present(alertController, animated: true, completion:nil)
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
