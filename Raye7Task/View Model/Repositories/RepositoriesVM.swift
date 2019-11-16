
import Foundation
class RepositoriesVM
{

    weak var dataSource : GenericDataSource<RepositoryElement>?
    var serviceAdapter : NetworkAdapter!
     var onErrorHandling : ((ErrorResult?) -> Void)?
     var loading : (() -> Void)!
     var stopLoading : (() -> Void)!
    var isDataReturned : Bool = true
    var pageNumber : Int = 1

    init(_serviceAdapter : NetworkAdapter, dataSource : GenericDataSource<RepositoryElement>?) {
           self.serviceAdapter = _serviceAdapter
           self.dataSource = dataSource
      }
    func getRepositories()
    {
        DispatchQueue.main.async {
           self.loading()
        }
        serviceAdapter.request(target: .getAllRepositories(page: pageNumber), success: { [unowned self] Response in
            do
            {
                let decoder = JSONDecoder()
                let getData = try decoder.decode(RepositoriesCodableModel.self,from: Response.data)
                DispatchQueue.global(qos: .background).async {
                    guard getData.count > 0 else {
                        self.isDataReturned = false
                        DispatchQueue.main.async {
                            self.stopLoading()
                        }
                        return
                    }
                    self.dataSource?.data.value = getData
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }
            catch let err { print("Err", err)}
            }, error: { Error in
                self.onErrorHandling?(ErrorResult.custom(string: Error.localizedDescription))
        }) { MoyaError in
            self.onErrorHandling?(ErrorResult.custom(string: MoyaError.localizedDescription))
        }
    }
    deinit {
        dataSource = nil
        serviceAdapter = nil
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

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
