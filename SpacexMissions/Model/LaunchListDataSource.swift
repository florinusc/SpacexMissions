//
//  LaunchListDataSource.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 13.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

typealias LaunchListDataSource = UITableViewDiffableDataSource<LaunchListSection, AnyHashable>
typealias LaunchListSnapshot = NSDiffableDataSourceSnapshot<LaunchListSection, AnyHashable>
