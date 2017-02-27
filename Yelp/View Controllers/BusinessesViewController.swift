//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking


class BusinessesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!

    var searchText: String = ""
    var sortMode = 0
    var categories = [String]()
    var deals = false
    var distance = 0
    
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        // Dynamic row height in table views
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Search Bar in Navigation View
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        

        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    
                }
            
                self.tableView.reloadData()
                
            
            }
        }
        
        
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
            loadingMoreView = InfiniteScrollActivityView(frame: frame)
            loadingMoreView!.isHidden = true
            tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
            insets.bottom += InfiniteScrollActivityView.defaultHeight
            tableView.contentInset = insets
        
    
    }

    
// --- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filtersSegue" {
            let navVC = segue.destination as! UINavigationController
            let filterVC = navVC.topViewController as! FiltersVC
        
            filterVC.delegate = self
        }
        
        if segue.identifier == "mapSegue" {
            let nextVC = segue.destination as! MapVC
            nextVC.businesses = businesses
        }
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    
}

// --- TableView
extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate, FiltersVCDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses == nil {
            return 0
        } else {
            return businesses.count
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
        
    }
    
    
    func filtersVC (filterVC: FiltersVC, didUpdateCategory category: [String], didUpdateDeals deals: Bool, didUpdateSortMode mode: Int, didUpdateDistance distance: Int) {
        
        print ("Received from FilterVC category \(category)")
        print ("Received from FilterVC deal \(deals)")
        
        Business.search(with: "", sort: YelpSortMode(rawValue: mode), categories: category, deals: deals, distance: distance) {
            (businesses: [Business]?, error: Error?) in
            
            if let businesses = businesses {
                self.businesses = businesses
                    
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                
               
                self.tableView.reloadData()
                
                self.categories = category
                self.deals = deals
                self.sortMode = mode
                self.distance = distance
                
                }
            }
        }
    }
    
    
    
// --- Infinite Scrolling
    
    // Detecting when to request more data
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            
            // When the user has scrolled past the threshold, start requesting
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                loadMoreData()
            }
        }
    }

    // Request more data
    func loadMoreData() {
        
        Business.search(with: searchText, sort: YelpSortMode(rawValue: sortMode), categories: nil, deals: deals, distance: distance) {
            (businesses: [Business]?, error: Error?) in
            
            self.isMoreDataLoading = false
            
            self.loadingMoreView!.stopAnimating()
            
            if let businesses = businesses {
                self.businesses = businesses
                
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    
                self.tableView.reloadData()
                }
   
            }
        }
    }
    
}
    


// --- Search Bar
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
        Business.search(with: searchText, sort: nil, categories: nil, deals: nil, distance: nil) {
                (businesses: [Business]?, error: Error?) in
            
            if let businesses = businesses {
                self.businesses = businesses
            
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                
            
                self.tableView.reloadData()
                self.searchText = searchText
                }

            }
        }
    }
}




// Creating a progress indicator - Infinite scroll
class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.isHidden = true
    }
    
    func startAnimating() {
        self.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
}






