//
//  LaunchListViewModel.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 13.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit
import Combine
import Algorithms

enum LaunchAction {
    case article
    case video
    case wikipedia
}

class LaunchListViewModel {
    
    private let repository: Repository
    
    var dataSource: LaunchListDataSource! {
        didSet {
            dataSource.apply(snapshot)
            dataSource.defaultRowAnimation = .fade
        }
    }
    
    var years: [Int] {
        let allYears = missions.compactMap { Date(timeIntervalSince1970: TimeInterval($0.dateTimestamp)).justYear }
        return allYears.uniqued().sorted()
    }
    
    var justSuccessfulLaunches = false {
        didSet {
            filterMissionsByLaunchSuccess()
        }
    }
    
    var ascendingOrder = false {
        didSet {
            sortMissionByLaunchDate()
        }
    }
    
    var startYear: Int? {
        didSet {
            filterMissionsByYear()
        }
    }
    
    var endYear: Int? {
        didSet {
            filterMissionsByYear()
        }
    }
    
    private var snapshot = LaunchListSnapshot()
    
    private var cancellable: AnyCancellable!
    
    private var missions = [Mission]()
    
    private var filteredMissions = [Mission]() {
        didSet {
            update(with: filteredMissions)
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getData(_ handler: @escaping (Error?) -> Void) {
        cancellable = Publishers.Zip(repository.fetchCompany(), repository.fetchMissions())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    handler(nil)
                case .failure(let error):
                    handler(error)
                }
            }, receiveValue: { [weak self] (company, missions) in
                self?.update(with: company)
                self?.missions = missions
                self?.filteredMissions = missions
            })
    }
    
    func header(for index: Int) -> String? {
        let sectionIdentifier = snapshot.sectionIdentifiers[safe: index]
        switch sectionIdentifier {
        case .companyInfo:
            return Localizer.company.localized
        case .launches:
            return Localizer.launches.localized
        case .none:
            return nil
        }
    }
    
    func actions(at index: Int) -> [LaunchAction] {
        let mission = filteredMissions[safe: index]
        var actions = [LaunchAction]()
        
        if mission?.wikipediaLink != nil {
            actions.append(.wikipedia)
        }
        
        if mission?.videoLink != nil {
            actions.append(.video)
        }
        
        if mission?.articleLink != nil {
            actions.append(.article)
        }
        
        return actions
    }
    
    func openWikipedia(at index: Int) {
        guard let missionWikipediaLink = filteredMissions[index].wikipediaLink,
              let url = URL(string: missionWikipediaLink)
        else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func openArticle(at index: Int) {
        guard let missionArticleLink = filteredMissions[index].articleLink,
              let url = URL(string: missionArticleLink)
        else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func openVideo(at index: Int) {
        guard let missionVideoLink = filteredMissions[index].videoLink,
              let url = URL(string: missionVideoLink)
        else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func update(with company: Company) {
        snapshot.deleteSections([.companyInfo])
        snapshot.appendSections([.companyInfo])
        snapshot.appendItems([CompanyInfoCellViewModel(company: company)], toSection: .companyInfo)
        dataSource.apply(snapshot)
    }
    
    private func update(with missions: [Mission]) {
        snapshot.deleteSections([.launches])
        snapshot.appendSections([.launches])
        snapshot.appendItems(missions.map({ MissionCellViewModel(mission: $0) }), toSection: .launches)
        dataSource.apply(snapshot)
    }
    
    private func filterMissionsByYear() {
        filteredMissions = missions.filter({ mission in
            if justSuccessfulLaunches && mission.launchSuccess == false { return false }
            guard let missionYear = Date(timeIntervalSince1970: TimeInterval(mission.dateTimestamp)).justYear else { return false }
            if let startYear = startYear, let endYear = endYear {
                return missionYear >= startYear && missionYear <= endYear
            } else if let startYear = startYear {
                return missionYear >= startYear
            } else if let endYear = endYear {
                return missionYear <= endYear
            } else {
                return false
            }
        })
        sortMissionByLaunchDate()
    }
    
    private func filterMissionsByLaunchSuccess() {
        if justSuccessfulLaunches {
            filteredMissions = filteredMissions.filter({ $0.launchSuccess == true })
        } else {
            filterMissionsByYear()
        }
    }
    
    private func sortMissionByLaunchDate() {
        if ascendingOrder {
            filteredMissions.sort(by: { $0.dateTimestamp > $1.dateTimestamp })
        } else {
            filteredMissions.sort(by: { $0.dateTimestamp < $1.dateTimestamp })
        }
    }
    
}
