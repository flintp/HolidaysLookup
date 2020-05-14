
//
//  HolidaysTableViewController.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 08/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class HolidaysTableViewController: UITableViewController {
    enum State {
        case awaitingInitialization
        case ready
        case searching
        case displayingResults
        case displayingError
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    
    private lazy var dataLoader = DataLoader()
    
    private var internalState = State.awaitingInitialization {
        didSet {
            switch internalState {
            case .awaitingInitialization:
                return
            case .ready:
                return
            case .searching:
                DispatchQueue.main.async {
                    self.title = " Searching..."
                    self.showLoaderView()
                }
            case .displayingError:
                DispatchQueue.main.async {
                    self.teardownLoaderView()
                    self.title = "No Results Found"
                }
            case .displayingResults:
                DispatchQueue.main.async {
                    self.teardownLoaderView()
                }
            }
        }
    }
    private lazy var loaderView = LoadingViewController()
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays Found"
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        mock()
    }
    
    //MARK: - Private
    
    private func setup() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        searchBar.delegate = self
        tableView.keyboardDismissMode = .interactive
        internalState = .ready
    }
    
    private func showLoaderView() {
        add(loaderView)
    }
    
    private func teardownLoaderView() {
        remove(loaderView)
    }
    
    private func mock() {
        let holidayRequest = HolidayRequest(countryCode: "UK")
        dataLoader.loadData(forRequest: holidayRequest) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = listOfHolidays[indexPath.row]
        
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HolidaysTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = HolidayDetailsViewController()
        nextViewController.holidaysData = listOfHolidays[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension HolidaysTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        internalState = .searching
        guard let searchBarText = searchBar.text else { return }
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        dataLoader.loadData(forRequest: holidayRequest) { [weak self] result in
            print(#function)
            switch result {
            case .failure(let error):
                self?.listOfHolidays.removeAll()
                self?.internalState = .displayingError
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
                self?.internalState = .displayingResults
            }
        }
    }
}
