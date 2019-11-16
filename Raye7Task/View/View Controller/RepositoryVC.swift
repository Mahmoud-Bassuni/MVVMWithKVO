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
    let dataSource = RepositoryDataSource()
    lazy var viewModel : RepositoriesVM! = {
        let viewModel = RepositoriesVM(_serviceAdapter: NetworkAdapter() , dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryTableView.tableFooterView = UIView()
        self.repositoryTableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.repositoryTableView.reloadData()
            }
        }
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        self.viewModel.loading = {
            SVProgressHUD.show(withStatus: "")
        }
        self.viewModel.stopLoading = {
            SVProgressHUD.dismiss()
        }
        self.viewModel.getRepositories()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    deinit {
        self.viewModel = nil
    }
}
//  confirm tableview protocol
//extension RepositoryVC : UITableViewDelegate , UITableViewDataSource
//{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.repositoryViewModel == nil ? 0 : self.repositoryViewModel.numberOfSections
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.repositoryViewModel.numberOfRowsInSection(section)
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTVC
//        let repositoryItem = self.repositoryViewModel.RepositoryAtIndex(indexPath.row)
//        cell.configCell(item: repositoryItem)
//        return cell;
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let url = self.repositoryViewModel.RepositoryAtIndex(indexPath.row).htmlURL
//       navigateURL(url: url, viewController: self)
//    }
//
//}
//-----

// pager area
extension RepositoryVC : UIScrollViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // chack if scrolling arrive at the end of table
        if (((self.repositoryTableView?.contentOffset.y)! + (self.repositoryTableView?.frame.size.height)!) >= (self.repositoryTableView?.contentSize.height)!){
            guard self.viewModel.isDataReturned == true else { return}
            viewModel.pageNumber += 1 ;
            self.viewModel.getRepositories()
        }
    }
}

