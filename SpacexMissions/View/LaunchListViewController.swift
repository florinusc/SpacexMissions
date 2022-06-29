//
//  LaunchListViewController.swift
//  SpacexMissions
//
//  Created by Ivo Silva on 18/09/2020.
//  Copyright © 2020 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit
import Combine

class LaunchListViewController: UIViewController {
    
    private let viewModel: LaunchListViewModel
    private weak var coordinator: MainCoordinator?
    
    @Published private var showFilter = false
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tableView])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.registerCell(CompanyInfoCell.self)
        tableView.registerCell(MissionCell.self)
        return tableView
    }()
    
    private var filterView: LaunchFilterView?
    
    init(viewModel: LaunchListViewModel, coordinator: MainCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        title = "SpaceX"
        view.backgroundColor = .systemBackground
        addSubViews()
        tableView.delegate = self
        viewModel.dataSource = createDataSource()
        getData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toggleFilter))
        addObserverForFilterView()
    }
    
    private func addObserverForFilterView() {
        $showFilter
            .sink(receiveValue: { [weak self] showFilter in
                guard let self = self else { return }
                guard let filterView = self.filterView else { return }
                switch showFilter {
                case true:
                    self.mainStackView.insertArrangedSubview(filterView, at: 0)
                case false:
                    self.mainStackView.removeArrangedSubview(filterView)
                    filterView.removeFromSuperview()
                }
            })
            .store(in: &cancellables)
    }
    
    private func getData() {
        let loader = loader()
        viewModel.getData { [weak self] error in
            self?.stopLoader(loader: loader)
            if let error = error {
                self?.presentAlert(for: error)
                return
            }
            self?.createFilterView()
        }
    }
    
    private func addSubViews() {
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func createFilterView() {
        filterView = LaunchFilterView(frame: .zero, years: viewModel.years)
        filterView?.startYearIndexValue
            .sink(receiveValue: { [weak self] index in
                self?.viewModel.startYear = self?.viewModel.years[safe: index]
            })
            .store(in: &cancellables)
        filterView?.endYearIndexValue
            .sink(receiveValue: { [weak self] index in
                self?.viewModel.endYear = self?.viewModel.years[safe: index]
            })
            .store(in: &cancellables)
        filterView?.launchSuccessToggleValue
            .sink(receiveValue: { [weak self] justSuccessfulLaunches in
                self?.viewModel.justSuccessfulLaunches = justSuccessfulLaunches
            })
            .store(in: &cancellables)
        filterView?.orderToggleValue
            .sink(receiveValue: { [weak self] ascendingOrder in
                self?.viewModel.ascendingOrder = ascendingOrder
            })
            .store(in: &cancellables)
    }
    
    private func createDataSource() -> LaunchListDataSource {
        return LaunchListDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            if let companyCellViewModel = itemIdentifier as? CompanyInfoCellViewModel {
                let cell: CompanyInfoCell = tableView.dequeueCell()
                cell.viewModel = companyCellViewModel
                return cell
            }
            if let missionCellViewModel = itemIdentifier as? MissionCellViewModel {
                let cell: MissionCell = tableView.dequeueCell()
                cell.viewModel = missionCellViewModel
                return cell
            }
            return nil
        }
    }
    
    private func presentActions(at index: Int) {
        let actions = viewModel.actions(at: index)
        guard actions.count > 0 else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for action in actions {
            switch action {
            case .wikipedia:
                let action = UIAlertAction(title: Localizer.wikipedia.localized, style: .default, handler: { [weak self] _ in
                    self?.viewModel.openWikipedia(at: index)
                })
                alert.addAction(action)
            case .article:
                let action = UIAlertAction(title: Localizer.article.localized, style: .default, handler: { [weak self] _ in
                    self?.viewModel.openArticle(at: index)
                })
                alert.addAction(action)
            case .video:
                let action = UIAlertAction(title: Localizer.video.localized, style: .default, handler: { [weak self] _ in
                    self?.viewModel.openVideo(at: index)
                })
                alert.addAction(action)
            }
        }
        
        let cancelAction = UIAlertAction(title: Localizer.cancel.localized, style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @objc private func toggleFilter() {
        showFilter.toggle()
    }
    
}

extension LaunchListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentActions(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = viewModel.header(for: section)
        headerView.addSubview(label)
        label.pinToSuperview(with: 10)
        return headerView
    }
    
}
