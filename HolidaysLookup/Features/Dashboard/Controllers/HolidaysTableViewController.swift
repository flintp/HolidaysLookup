
//
//  HolidaysTableViewController.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 08/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

enum ViewState<Model> {
    case ready
    case loading
    case presenting(Model)
    case failed(Error)
}

class HolidaysTableViewController: UITableViewController {
    
    //MARK: – Controllers
    private let logic = HolidaysLogicController()
    private let modelController = HolidaysModelController(model: HolidaysModel())
    
    //MARK: - View State
    private var viewState: ViewState<[HolidayDetail]>  = .ready {
        didSet {
            switch viewState {
            case .ready:
                return
            case .loading:
                DispatchQueue.main.async {
                    self.title = " Searching..."
                    self.showLoaderView()
                }
            case .failed(let error):
                print(error)
                modelController.deleteModel()
                DispatchQueue.main.async {
                    self.teardownLoaderView()
                    self.tableView.reloadData()
                    self.title = "No Results Found"
                }
            case .presenting(let holidays):
                modelController.transform(rawModel: holidays)
                DispatchQueue.main.async {
                    self.teardownLoaderView()
                    self.tableView.reloadData()
                    self.navigationItem.title = "\(self.modelController.totalNumberOfHolidays) Holidays Found"
                }
            }
        }
    }
        
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    private lazy var loaderView = LoadingViewController()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: - Private
    private func setupUI() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        tableView.register(HolidaysSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")

        searchBar.delegate = self
        tableView.keyboardDismissMode = .interactive
        clearsSelectionOnViewWillAppear = true
    }
    
    private func render(state: ViewState<[HolidayDetail]>) {
        viewState = state
    }
    
    private func showLoaderView() {
        add(loaderView)
    }
    
    private func teardownLoaderView() {
        remove(loaderView)
    }

    // MARK: - IBActions
    @IBAction func examplesButtonPressed(_ sender: Any) {
        let nextViewController = ExamplesViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HolidaysTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return modelController.numberOfMonths
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.numberOfDaysForMonth(section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? HolidaysSectionHeaderView
        headerView?.setText(Calendar.current.monthSymbols[section])
        headerView?.setTextColor(UIColor.HolidayTheme.colorsInOrder[section]) 
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = modelController.holidayName(for: indexPath)
        cell.detailTextLabel?.text = modelController.formattedDateText(for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HolidaysTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = HolidayDetailsViewController(model: modelController.getIndividualHoliday(for: indexPath))
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension HolidaysTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        render(state: .loading)
        logic.loadCurrentState(usingSearchQuery: searchBarText) { [weak self] state in
            self?.render(state: state)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension HolidaysTableViewController {
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
