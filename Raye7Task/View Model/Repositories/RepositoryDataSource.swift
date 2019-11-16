//
//  ssw.swift
//  Raye7Task
//
//  Created by Bassuni on 11/16/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
import UIKit
 class RepositoryDataSource : GenericDataSource<RepositoryElement>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTVC
           let repositoryItem = self.data.value[indexPath.row]
           cell.configCell(item: RepositoryVM(repositoryItem))
           return cell;
       }
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let repositoryItem = self.data.value[indexPath.row]
//            let url = RepositoryVM(repositoryItem).htmlURL
//           navigateURL(url: url, viewController: self)
//        }

}
