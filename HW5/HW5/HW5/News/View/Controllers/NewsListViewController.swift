import UIKit

final class NewsListViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var isLoading = true
    private var newsViewModels = [NewsViewModel]()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchNews()
    }

    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
        setupNavbar()
    }

    private func setupNavbar() {
        navigationItem.title = "Articles"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gobackward"),
            style: .plain,
            target: self,
            action: #selector(loadNews)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
    }

    private func setTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
        tableView.register(LoadingNewsCell.self, forCellReuseIdentifier: LoadingNewsCell.reuseIdentifier)
    }

    private func fetchNews() {
        ApiService.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsViewModels = articles.compactMap{
                    NewsViewModel(
                        title: $0.title,
                        description: $0.description ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                }

                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Objc functions
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func loadNews() {
        isLoading = false
        fetchNews()
        tableView.reloadData()
    }
}

// MARK: - Extensions
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 6
        } else {
            return newsViewModels.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            if let loadingNewsCell = tableView.dequeueReusableCell(withIdentifier: LoadingNewsCell.reuseIdentifier, for: indexPath) as? LoadingNewsCell {
                return loadingNewsCell
            }
        } else {
            let viewModel = newsViewModels[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
                newsCell.configure(with: viewModel)
                return newsCell
            }
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let newsVC = NewsViewController()
            newsVC.configure(with: newsViewModels[indexPath.row])
            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}
