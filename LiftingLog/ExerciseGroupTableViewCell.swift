//
//  ExerciseGroupTableViewCell.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

class ExerciseGroupTableViewCell: UITableViewCell {
  
  @IBOutlet weak var exerciseCategoryLabel: UILabel!
  @IBOutlet weak var exerciseNameLabel: UILabel!
  @IBOutlet weak var setsMultilineLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
