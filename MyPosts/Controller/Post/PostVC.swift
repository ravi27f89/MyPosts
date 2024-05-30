//
//  PostVC.swift
//  MyPosts
//

import UIKit
enum Const {
    static let prototypeCell = "postcell"
}

class PostVC: UIViewController {

    @IBOutlet weak var tblPost: UITableView!

    private lazy var postVM: PostVM = {
        return .init()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        self.postVM.delegate = self
        tblPost.dataSource = self
        tblPost.delegate = self
    }
}

extension PostVC: PostVMDelegate {
    func postVMDidUpdate(_ viewModel: PostVM) {
        DispatchQueue.main.async {
            self.tblPost.reloadData()
        }
    }
}

// MARK: - 🆗 Table View 💢  Data source 💢
extension PostVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postVM.postCount
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: Const.prototypeCell, for: indexPath)
        let model = postVM.post(at: indexPath.row)
        postCell.textLabel?.text = model.title
        postCell.detailTextLabel?.text = model.body
        return postCell
    }
}

// MARK: - 🆗 Table View 💢 Delegate 💢
extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
