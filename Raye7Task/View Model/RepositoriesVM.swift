//
//  RepositoryVM.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
protocol RepositoryVMDelegate : BaseProtocol
{
    func dataBind()
}

class RepositoriesVM
{
    var delegate : RepositoryVMDelegate?
    var Repositories : RepositoriesCodableModel = []
    var isDataReturned : Bool = true
    var pageNumber : Int = 0
    init() {
        getRepositories()
    }
    func getRepositories()
    {
        DispatchQueue.main.async {
            self.delegate?.showLoading()
        }
        NetworkAdapter.request(target: .getAllRepositories(page: pageNumber), success: { [unowned self] Response in
            do
            {
                let decoder = JSONDecoder()
                let getData = try decoder.decode(RepositoriesCodableModel.self,from: Response.data)
                DispatchQueue.global(qos: .background).async {
                    guard getData.count > 0 else {
                        self.isDataReturned = false
                        DispatchQueue.main.async {
                            self.delegate?.hideLoading()
                        }
                        return
                    }
                    for item in getData
                    {
                        self.Repositories.append(item)
                    }
                    DispatchQueue.main.async {
                        self.delegate?.dataBind()
                    }
                }
            }
            catch let err { print("Err", err)}
            }, error: { Error in
                self.delegate?.showAlert(messgae: Error.localizedDescription)
        }) { MoyaError in
            self.delegate?.showAlert(messgae: MoyaError.localizedDescription)
        }
    }
    deinit {
        Repositories = []
    }
}
extension RepositoriesVM {
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.Repositories.count
    }

    func RepositoryAtIndex(_ index: Int) -> RepositoryVM {
        let repository = Repositories[index]
        return RepositoryVM(repository)
    }

}
struct RepositoryVM {
    private let repository: RepositoryElement
    init(_ repository: RepositoryElement) {
        self.repository = repository
    }
}
extension RepositoryVM {
    var name: String {
        return self.repository.name
    }
    var description: String {
        return self.repository.reposCodableModelDescription ?? ""
    }
    var forksCount: Int {
        return self.repository.forksCount ?? 0
    }
    var language: String {
        return self.repository.language ?? ""
    }
    var createdAt: String {
        return self.repository.createdAt ?? ""
    }
    var htmlURL: String {
        return self.repository.htmlURL ?? ""
    }
    var photo: String {
        return self.repository.owner == nil ? "" :  self.repository.owner.avatarURL
    }
}


