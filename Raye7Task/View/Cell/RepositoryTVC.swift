//
//  RepositoryTVC.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import UIKit

class RepositoryTVC: UITableViewCell {
    @IBOutlet var viewCardProp: UIView!
    @IBOutlet var userImageProp: CustomImageView!
    @IBOutlet var descriptionTxt: UILabel!
    @IBOutlet var titleTxt: UILabel!
    @IBOutlet var creationDateTxt: UILabel!
    @IBOutlet var languageTxt: UILabel!
    @IBOutlet var forkCountTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCardProp.card()
        // Initialization code
    }

    func configCell(item : RepositoryVM)  {
        titleTxt.text = item.name
        descriptionTxt.text = item.description
        creationDateTxt.text = item.createdAt
        languageTxt.text = item.language
        forkCountTxt.text = "\(item.forksCount)"
        userImageProp.loadImageUsingUrlString(urlString : item.photo)

    }

}
