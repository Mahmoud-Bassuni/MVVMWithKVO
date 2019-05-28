
import Foundation
typealias RepositoriesCodableModel = [RepositoryElement]
struct RepositoryElement: Codable {

    let name : String!
    let reposCodableModelDescription: String!
    let forksCount: Int!
    let language: String!
    let createdAt: String!
    let htmlURL: String!
    let owner: Owner!
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case reposCodableModelDescription = "description"
        case forksCount = "forks_count"
        case language
        case createdAt = "created_at"
    }
}
// MARK: - Owner
struct Owner: Codable {
    let avatarURL: String!

    enum CodingKeys: String, CodingKey {
      
        case avatarURL = "avatar_url"
    }
}

