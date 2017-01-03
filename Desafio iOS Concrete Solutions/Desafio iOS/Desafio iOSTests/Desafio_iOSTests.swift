//
//  Desafio_iOSTests.swift
//  Desafio iOSTests
//
//  Created by Christian Perrone on 07/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import XCTest
import UIKit
import ObjectMapper
@testable import Desafio_iOS

class Desafio_iOSTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepositoryItem() {
        let name = "repository"
        let description = "repository description"
        let forks = 99
        let stars = 10
        let login = "username"
        let avatarString = "https://avatars.githubusercontent.com/u/6764390?v=3"
        let json = "{\"items\":[{\"name\":\"\(name)\", \"description\":\"\(description)\", \"forks\":\(forks), \"stargazers_count\":\(stars), \"owner\":{\"login\":\"\(login)\", \"avatar_url\":\"\(avatarString)\"}}]}"
        
        let repository = Mapper<RepositoryItems>().map(JSONString: json)
        
        XCTAssertNotNil(repository)
        XCTAssertNotNil(repository?.items)
        
//        guard let items = repository?.items else { return }
        if let items = repository?.items {
            XCTAssertGreaterThan(items.count, 0)

        }
        
        
//        let repositoryTest: Repository
//        XCTAssertEqual(items[0], repositoryTest)
    }
    
    func testRepositoryOwner() {
        let login = "username"
        let avatarURL = URL(string: "https://avatars.githubusercontent.com/u/6764390?v=3")
        let avatarString = "https://avatars.githubusercontent.com/u/6764390?v=3"
        let json = "{\"login\":\"\(login)\", \"avatar_url\":\"\(avatarString)\"}"
        
        let repository = Mapper<RepositoryOwner>().map(JSONString: json)
        
        XCTAssertEqual(repository?.username, login)
        XCTAssertEqual(repository?.avatarUrl, avatarURL)
    }
    
    func testRepository() {
        let name = "repository"
        let description = "repository description"
        let forks = 99
        let stars = 10
        let login = "username"
        let avatarString = "https://avatars.githubusercontent.com/u/6764390?v=3"
        let avatarURL = URL(string: avatarString)
        let json = "{\"name\":\"\(name)\", \"description\":\"\(description)\", \"forks\":\(forks), \"stargazers_count\":\(stars), \"owner\":{\"login\":\"\(login)\", \"avatar_url\":\"\(avatarString)\"}}"
        
        let repository = Mapper<Repository>().map(JSONString: json)

        XCTAssertNotNil(repository?.owner)
        XCTAssertEqual(repository?.name, name)
        XCTAssertEqual(repository?.description, description)
        XCTAssertEqual(repository?.forks, forks)
        XCTAssertEqual(repository?.stars, stars)
        XCTAssertEqual(repository?.owner?.username, login)
        XCTAssertEqual(repository?.owner?.avatarUrl, avatarURL)

    }
    
    func testPullRequest() {
        let name = "pull request"
        let body = "pull request body"
        let linkString = "https://github.com/Alamofire/Alamofire/pull/1854"
        let linkURL = URL(string: linkString)
        let json = "{\"title\":\"\(name)\", \"body\":\"\(body)\", \"html_url\":\"\(linkString)\", \"user\": {}}"
        
        let pullRequest = Mapper<PullRequest>().map(JSONString: json)
        
        XCTAssertEqual(pullRequest?.name, name)
        XCTAssertEqual(pullRequest?.body, body)
        XCTAssertEqual(pullRequest?.link, linkURL)
        XCTAssertNotNil(pullRequest?.user)
        
    }
    
    func testPullRequestUser() {
        let avatarString = "https://avatars.githubusercontent.com/u/51020?v=3"
        let avatarURL = URL(string: avatarString)
        let login = "user name"
        let json = "{\"avatar_url\":\"\(avatarString)\", \"login\":\"\(login)\"}"
        
        let pullRequestUser = Mapper<PullRequestUser>().map(JSONString: json)
        
        XCTAssertEqual(pullRequestUser?.avatarUrl, avatarURL)
        XCTAssertEqual(pullRequestUser?.username, login)
    }
}
