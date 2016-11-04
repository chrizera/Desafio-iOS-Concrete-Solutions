//
//  RepositoryTableViewCell.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 01/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pullRequestTitle: UILabel!
    @IBOutlet weak var pullRequestDescription: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
