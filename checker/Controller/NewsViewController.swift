//
//  NewsViewController.swift
//  checker
//
//  Created by Julia Semyzhenko on 7/17/22.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        fetchTopStories()
    }
    
    private func fetchTopStories() {
        APICallerNews.shared.getNewsData { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles  = articles
                self?.viewModels =  articles.compactMap({ NewsTableViewCellViewModel(
                    title: $0.title,
                    subtitle: $0.description ?? "No description",
                    imageURL: URL(string: $0.urlToImage ?? "" )
                )
                })
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath)
                as? NewsTableViewCell else { fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        newsTableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

