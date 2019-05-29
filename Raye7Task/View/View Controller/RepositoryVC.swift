//
//  repositoryVM.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import UIKit
import SVProgressHUD
class RepositoryVC: UIViewController {
    // IBOutlet and objects
    @IBOutlet weak var repositoryTableView: UITableView!
    var repositoryViewModel : RepositoriesVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
        repositoryTableView.tableFooterView = UIView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repositoryViewModel = RepositoriesVM()
        repositoryViewModel.delegate = self
    }
}
//  confirm tableview protocol
extension RepositoryVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.repositoryViewModel == nil ? 0 : self.repositoryViewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryViewModel.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTVC
        let repositoryItem = self.repositoryViewModel.RepositoryAtIndex(indexPath.row)
        cell.configCell(item: repositoryItem)
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.repositoryViewModel.RepositoryAtIndex(indexPath.row).htmlURL
       navigateURL(url: url, viewController: self)
    }

}
//-----
//  confirm vm delegate
extension RepositoryVC : RepositoryVMDelegate
{
    func dataBind() {
        SVProgressHUD.dismiss()
        self.repositoryTableView.reloadData()
    }
    func showLoading() {
        SVProgressHUD.show(withStatus: "")
    }
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    func showAlert(messgae: String) {
        SVProgressHUD.dismiss()
        alert(title: "validation",message: messgae)
    }
}
//
// pager area
extension RepositoryVC : UIScrollViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // chack if scrolling arrive at the end of table
        if (((self.repositoryTableView?.contentOffset.y)! + (self.repositoryTableView?.frame.size.height)!) >= (self.repositoryTableView?.contentSize.height)!){
            guard self.repositoryViewModel.isDataReturned == true else { return}
            repositoryViewModel.pageNumber += 1 ;
            self.repositoryViewModel.getRepositories()
        }
    }
}

