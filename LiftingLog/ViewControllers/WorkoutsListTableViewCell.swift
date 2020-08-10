//
//  WorkoutsListTableViewCell.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/31.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class WorkoutsListTableViewCell: UITableViewCell {

  @IBOutlet weak var workoutStarsLabel: UILabel!
  @IBOutlet weak var workoutNumberAndDateLabel: UILabel!
  @IBOutlet weak var workoutDetailsLabel: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
    }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
