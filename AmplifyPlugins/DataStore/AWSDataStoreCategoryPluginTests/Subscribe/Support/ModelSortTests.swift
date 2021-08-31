//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import XCTest
import Combine

@testable import Amplify
@testable import AmplifyTestCommon
@testable import AWSPluginsCore
@testable import AWSDataStoreCategoryPlugin

class ModelSortTests: XCTestCase {

    func testSortModelString() throws {
        let post1 = createPost(id: "1")
        let post2 = createPost(id: "2")
        let post3 = createPost(id: "3")
        var posts = [post2, post3, post1]

        posts.sortModels(by: .ascending(Post.keys.id), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].id, "1")
        XCTAssertEqual(posts[1].id, "2")
        XCTAssertEqual(posts[2].id, "3")

        posts.sortModels(by: .descending(Post.keys.id), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].id, "3")
        XCTAssertEqual(posts[1].id, "2")
        XCTAssertEqual(posts[2].id, "1")
    }

    func testSortModelOptionalString() {
        func createModelWithOptionalString(_ myString: String?) -> QPredGen {
            QPredGen(name: "name", myString: myString)
        }

        let model1 = createModelWithOptionalString("1")
        let model2 = createModelWithOptionalString(nil)
        let model3 = createModelWithOptionalString("2")
        var models = [model1, model2, model3]

        models.sortModels(by: .ascending(QPredGen.keys.myString), modelSchema: QPredGen.schema)
        XCTAssertEqual(models[0].myString, nil)
        XCTAssertEqual(models[1].myString, "1")
        XCTAssertEqual(models[2].myString, "2")
        models.sortModels(by: .descending(QPredGen.keys.myString), modelSchema: QPredGen.schema)
        XCTAssertEqual(models[0].myString, "2")
        XCTAssertEqual(models[1].myString, "1")
        XCTAssertEqual(models[2].myString, nil)
    }

    func testSortModelInt() {

    }

    func testSortModelOptionalInt() {
        func createModelWithOptionalInt(_ myInt: Int?) -> QPredGen {
            QPredGen(name: "name", myInt: myInt)
        }

        let model1 = createModelWithOptionalInt(1)
        let model2 = createModelWithOptionalInt(nil)
        let model3 = createModelWithOptionalInt(2)
        var models = [model1, model2, model3]

        models.sortModels(by: .ascending(QPredGen.keys.myInt), modelSchema: QPredGen.schema)
        XCTAssertEqual(models[0].myInt, nil)
        XCTAssertEqual(models[1].myInt, 1)
        XCTAssertEqual(models[2].myInt, 2)
        models.sortModels(by: .descending(QPredGen.keys.myInt), modelSchema: QPredGen.schema)
        XCTAssertEqual(models[0].myInt, 2)
        XCTAssertEqual(models[1].myInt, 1)
        XCTAssertEqual(models[2].myInt, nil)
    }

    func testSortModelDouble() {
        let post1 = createPost(rating: 1.0)
        let post2 = createPost(rating: 2.0)
        let post3 = createPost(rating: 3.0)
        var posts = [post2, post3, post1]

        posts.sortModels(by: .ascending(Post.keys.rating), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].rating, 1.0)
        XCTAssertEqual(posts[1].rating, 2.0)
        XCTAssertEqual(posts[2].rating, 3.0)

        posts.sortModels(by: .descending(Post.keys.rating), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].rating, 3.0)
        XCTAssertEqual(posts[1].rating, 2.0)
        XCTAssertEqual(posts[2].rating, 1.0)
    }

    func testSortModelOptionalDouble() {
    }

    func testSortModelDate() {

    }

    func testSortModelOptionalDate() {

    }

    func testSortModelDateTime() {
        let dateTime1 = Temporal.DateTime.now()
        let dateTime2 = Temporal.DateTime.now().add(value: 1, to: .day)
        let dateTime3 = Temporal.DateTime.now().add(value: 1, to: .day)
        let post1 = createPost(createdAt: dateTime1)
        let post2 = createPost(createdAt: dateTime2)
        let post3 = createPost(createdAt: dateTime3)
        var posts = [post2, post3, post1]

        posts.sortModels(by: .ascending(Post.keys.createdAt), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].createdAt, dateTime1)
        XCTAssertEqual(posts[1].createdAt, dateTime2)
        XCTAssertEqual(posts[2].createdAt, dateTime3)

        posts.sortModels(by: .descending(Post.keys.createdAt), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].createdAt, dateTime3)
        XCTAssertEqual(posts[1].createdAt, dateTime2)
        XCTAssertEqual(posts[2].createdAt, dateTime1)
    }

    func testSortModelOptionalDateTime() {
    }

    func testSortModelTime() {

    }

    func testSortModelOptionalTime() {

    }

    func testSortModelTimestamp() {

    }

    func testSortModelOptionalTimestamp() {

    }

    func testSortModelBool() {
        let post1 = createPost(draft: true)
        let post2 = createPost(draft: false)
        let post3 = createPost(draft: true)

        var posts = [post1, post2, post3]

        posts.sortModels(by: .ascending(Post.keys.draft), modelSchema: Post.schema)

        XCTAssertEqual(posts[0].draft, true)
        XCTAssertEqual(posts[1].draft, true)
        XCTAssertEqual(posts[2].draft, false)
        posts.sortModels(by: .descending(Post.keys.draft), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].draft, false)
        XCTAssertEqual(posts[1].draft, true)
        XCTAssertEqual(posts[2].draft, true)
    }

    func testSortModelOptionalBool() {
    }

    func testSortModelEnum() {
        let post1 = createPost(status: .draft)
        let post2 = createPost(status: .private)
        let post3 = createPost(status: .published)
        var posts = [post1, post2, post3]

        posts.sortModels(by: .ascending(Post.keys.status), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].status, .draft)
        XCTAssertEqual(posts[1].status, .private)
        XCTAssertEqual(posts[2].status, .published)
        posts.sortModels(by: .descending(Post.keys.status), modelSchema: Post.schema)
        XCTAssertEqual(posts[0].status, .published)
        XCTAssertEqual(posts[1].status, .private)
        XCTAssertEqual(posts[2].status, .draft)
    }

    func testSortModelOptionalEnum() {
    }

    // MARK: - Helpers

    func createPost(id: String = UUID().uuidString,
                    draft: Bool = false,
                    rating: Double = 1.0,
                    createdAt: Temporal.DateTime = .now(),
                    status: PostStatus = .draft) -> Post {
        Post(id: id,
             title: "A",
             content: "content",
             createdAt: createdAt,
             updatedAt: .now(),
             draft: false,
             rating: rating,
             status: status,
             comments: nil)
    }

}
