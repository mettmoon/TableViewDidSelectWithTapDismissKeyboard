//
//  ViewController.swift
//  TableViewWithTapGesture
//
//  Created by peter on 2023/01/04.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var cellChecked:[IndexPath : Bool] = [:]
    override func loadView() {
        super.loadView()
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
    }
    lazy var tapGR = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGR:)))
    private var keyboardObservers: [AnyObject] = []

    @objc
    private func tapAction(tapGR: UITapGestureRecognizer) {
        self.tableView.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapGR.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(self.tapGR)

        self.keyboardObservers = [
            NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillShowNotification, object: nil, queue: .main, using: {[weak self] notification in
                guard let owner = self,
                      let keyboardFrame = (notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                    return
                }
                owner.tableView.contentInset.bottom = keyboardFrame.height - owner.tableView.safeAreaInsets.bottom
                owner.tableView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height - owner.tableView.safeAreaInsets.bottom
            }),
            NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillHideNotification, object: nil, queue: .main, using: {[weak self] _ in
                guard let owner = self else {
                    return
                }
                owner.tableView.contentInset.bottom = 0
                owner.tableView.verticalScrollIndicatorInsets.bottom = 0
            })
        ]
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
        cell.isChecked = self.cellChecked[indexPath] == true
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:\(indexPath)")
        let oldValue = self.cellChecked[indexPath] ?? false
        self.cellChecked[indexPath] = !oldValue
        self.tableView.reloadData()
    }
}

