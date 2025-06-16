import XCTest
import Foundation_iOS

class EndpointBuilderTests: XCTestCase {
    private struct Pagination: Codable {
        var offset: Int
        var count: Int
    }

    private struct ProjectVote: Equatable, Codable {
        enum CodingKeys: String, CodingKey {
            case projectId
            case votes
        }

        var projectId: String
        var votes: String
    }

    func testQueryParams() {
        // given
        let offset = 10
        let count = 10
        let template = "https://project.test-1.novasama.io/project?offset={offset}&count={count}"
        let enpointBuilder = EndpointBuilder(urlTemplate: template)

        do {
            let url = try enpointBuilder.buildURL(with: Pagination(offset: offset, count: count))

            let expectedUrl = URL(string: "https://project.test-1.novasama.io/project?offset=\(offset)&count=\(count)")

            XCTAssertEqual(url, expectedUrl)

            let regex = try enpointBuilder.buildRegex()
            let expectedRegex = "https://project\\.test-1\\.novasama\\.io/project\\?offset=\(EndpointBuilder.regexReplacement)&count=\(EndpointBuilder.regexReplacement)"
            XCTAssertEqual(regex, expectedRegex)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testPathWithQueryParams() {
        // given
        let projectId = "1234"
        let votes = "10.2"
        let template = "https://project.test-1.novasama.io/project/{projectId}/vote?{votes}"
        let enpointBuilder = EndpointBuilder(urlTemplate: template)

        do {
            let url = try enpointBuilder.buildURL(with: ProjectVote(projectId: projectId, votes: votes))

            let expectedUrl = URL(string: "https://project.test-1.novasama.io/project/\(projectId)/vote?\(votes)")

            XCTAssertEqual(url, expectedUrl)

            let regex = try enpointBuilder.buildRegex()
            let expectedRegex = "https://project\\.test-1\\.novasama\\.io/project/\(EndpointBuilder.regexReplacement)/vote\\?\(EndpointBuilder.regexReplacement)"
            XCTAssertEqual(regex, expectedRegex)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testSingleParameter() {
        // given
        let code = "123213"
        let template = "https://account.test-1.novasama.io/invitations/{invitationCode}"
        let enpointBuilder = EndpointBuilder(urlTemplate: template)

        do {
            let url = try enpointBuilder.buildParameterURL(code)
            let expectedUrl = URL(string: "https://account.test-1.novasama.io/invitations/\(code)")

            XCTAssertEqual(url, expectedUrl)
        } catch {
            XCTFail("Error: \(error)")
        }
    }
}
