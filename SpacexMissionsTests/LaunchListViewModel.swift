//
//  LaunchListViewModel.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 20.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import XCTest
@testable import SpacexMissions

class LaunchListViewModelTests: XCTestCase {
    
    func test_years_beforeGettingData_isEmpty() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: false)
        XCTAssertEqual(viewModel.years, [])
    }
    
    func test_years_afterGettingData_isCorrect() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertEqual(viewModel.years, [2020, 2022])
    }
    
    func test_justSuccessfulLaunches_initially_isFalse() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertEqual(viewModel.justSuccessfulLaunches, false)
    }
    
    func test_ascendingOrder_initially_isFalse() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertEqual(viewModel.ascendingOrder, false)
    }
    
    func test_startYear_initially_isNil() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertNil(viewModel.startYear)
    }
    
    func test_endYear_initially_isNil() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertNil(viewModel.endYear)
    }
    
    func test_getData_withoutRepositoryError_errorIsNil() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: false)
        let expectation = XCTestExpectation()
        viewModel.getData { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getData_withRepositoryError_errorIsNotNil() {
        let viewModel = createSUT(withRepositoryError: true, afterGettingData: false)
        let expectation = XCTestExpectation()
        viewModel.getData { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_header_atValidIndex_isNotNil() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertNotNil(viewModel.header(for: 0))
    }
    
    func test_header_atInvalidIndex_isNil() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        XCTAssertNil(viewModel.header(for: 2))
    }
    
    func test_actions_atIndexWithArticle_isCorrect() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        let actions = viewModel.actions(at: 0)
        XCTAssertEqual(actions, [.article])
    }
    
    func test_actions_atIndexWithWikipedia_isCorrect() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        let actions = viewModel.actions(at: 2)
        XCTAssertEqual(actions, [.wikipedia])
    }
    
    func test_actions_atIndexWithVideo_isCorrect() {
        let viewModel = createSUT(withRepositoryError: false, afterGettingData: true)
        let actions = viewModel.actions(at: 1)
        XCTAssertEqual(actions, [.video])
    }
    
    private func createSUT(withRepositoryError: Bool, afterGettingData: Bool) -> LaunchListViewModel {
        let viewModel = LaunchListViewModel(repository: RepositoryMock(shouldReturnError: withRepositoryError))
        viewModel.dataSource = LaunchListDataSource(tableView: UITableView(), cellProvider: { tableView, indexPath, itemIdentifier in
            return UITableViewCell()
        })
        if afterGettingData {
            let expectation = XCTestExpectation()
            viewModel.getData { error in
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
        }
        return viewModel
    }
    
}
