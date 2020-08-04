//
//  WorkoutDetaillTableViewCell.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/31.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class WorkoutDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var exerciseCategoryLabel: UILabel!
  @IBOutlet weak var exerciseNameLabel: UILabel!
  @IBOutlet weak var setsMultilineLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
