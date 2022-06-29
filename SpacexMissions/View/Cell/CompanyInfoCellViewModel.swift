//
//  CompanyInfoCellViewModel.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct CompanyInfoCellViewModel: Hashable {
    
    private let company: Company
    
    lazy var companyDescription: String = {
        return String(format: Localizer.companyInfo.localized,
                      company.name,
                      company.founder,
                      "\(company.founded)",
                      "\(company.employees)",
                      "\(company.launchSites)",
                      company.valuation.formattedWithSeparator)
    }()
    
    init(company: Company) {
        self.company = company
    }
    
}
