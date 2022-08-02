//
//  StocksAllsViewController.swift
//  checker
//
//  Created by Julia Semyzhenko on 7/17/22.
//

import UIKit

class StocksAllsViewController: UIViewController {
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCaller.shared.getStocksData { result in
            switch result  {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension StocksAllsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
