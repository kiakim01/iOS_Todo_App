//
//  SegmentedControl.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/10.
//

import UIKit


class UseSegmentedControlView:UIViewController{
    
    // MARK: Properties : 프로퍼티가 뭔지 찾아보기
    var numberOfItems = 3 // initial number of rows
    var switchStates: [IndexPath: Bool] = [:] // Dictionary to store UISwitch states for each cell
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.firstView.isHidden = shouldHideFirstView
            self.secondView.isHidden = !self.firstView.isHidden
        }
    }
    
    // MARK: UI : 얘는 func화 하는게 안되네 ... ? 찾아보자
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Todo", "Complete"])
        let font = UIFont.systemFont(ofSize: 30)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    let firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let addButton : UIButton = {
        let addButton = UIButton()
        addButton.setTitle("추가하기", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitleColor(UIColor(hex: "187afe"), for: .normal)
        addButton.layer.borderColor = UIColor(hex: "187afe").cgColor
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 10
        addButton.addTarget(UseSegmentedControlView.self, action: #selector(addTableCell), for:.touchUpInside)
        return addButton
    }()
    
    let deleteAllButton: UIButton = {
        let deleteAllButton = UIButton()
        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        deleteAllButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAllButton.setTitleColor(UIColor(hex: "187afe"), for: .normal)
        deleteAllButton.layer.borderColor = UIColor(hex: "187afe").cgColor
        deleteAllButton.layer.borderWidth = 1
        deleteAllButton.layer.cornerRadius = 10
        deleteAllButton.addTarget(UseSegmentedControlView.self, action: #selector(deleteAllCell), for: .touchUpInside)
        return deleteAllButton
    }()
    
    let firstTableView: UITableView = {
        let firstTableView = UITableView()
        firstTableView.translatesAutoresizingMaskIntoConstraints = false
        return firstTableView
    }()
    let seconTableView: UITableView = {
        let seconTableView = UITableView()
        seconTableView.translatesAutoresizingMaskIntoConstraints = false
        return seconTableView
    }()
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        firstTableView.dataSource = self
        firstTableView.delegate = self
        seconTableView.dataSource = self
        seconTableView.delegate = self
        // Register cell class or nib if needed
        firstTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        seconTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")

    }

    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            // 여기에서 실제 삭제 작업을 수행합니다.
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}


extension  UseSegmentedControlView{
    func configureUI(){
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        self.firstView.addSubview(addButton)
        self.firstView.addSubview(firstTableView)
        self.secondView.addSubview(deleteAllButton)
        self.secondView.addSubview(seconTableView)
        setLayout()
    }
    
    func setLayout(){
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        NSLayoutConstraint.activate([
            self.firstView.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.firstView.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.firstView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.firstView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            self.secondView.leftAnchor.constraint(equalTo: self.firstView.leftAnchor),
            self.secondView.rightAnchor.constraint(equalTo: self.firstView.rightAnchor),
            self.secondView.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor),
            self.secondView.topAnchor.constraint(equalTo: self.firstView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            firstTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            firstTableView.leadingAnchor.constraint(equalTo: self.firstView.leadingAnchor),
            firstTableView.trailingAnchor.constraint(equalTo: self.firstView.trailingAnchor),
            firstTableView.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor),
        ])
        
    
        NSLayoutConstraint.activate([
            seconTableView.topAnchor.constraint(equalTo: deleteAllButton.bottomAnchor,constant: 20),
            seconTableView.leadingAnchor.constraint(equalTo: self.secondView.leadingAnchor),
            seconTableView.trailingAnchor.constraint(equalTo: self.secondView.trailingAnchor),
            seconTableView.bottomAnchor.constraint(equalTo: self.secondView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            deleteAllButton.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 20),
            deleteAllButton.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
            deleteAllButton.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
            deleteAllButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}


extension UseSegmentedControlView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        var textField = cell.viewWithTag(123) as? UITextField
        if textField == nil {
            textField = UITextField(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width - 80, height: cell.contentView.bounds.height))
            textField?.placeholder = "Enter text"
            textField?.tag = 123
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.contentView.addSubview(textField!)
        }
        
        let toggle = UISwitch()
        toggle.isOn = switchStates[indexPath] ?? true
        toggle.onTintColor = UIColor(hex: "187afe")
        toggle.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        toggle.frame.origin = CGPoint(x: cell.contentView.bounds.width - toggle.bounds.width - 8, y: (cell.contentView.bounds.height - toggle.bounds.height) / 2)
        cell.contentView.addSubview(toggle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func updateText(_ newText: String, for indexPath: IndexPath) {
        if let cell = firstTableView.cellForRow(at: indexPath) {
            cell.textLabel?.text = newText
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .destructive, title: "Complete") { [weak self] (action, view, completionHandler) in
            guard self != nil else { return }
            completionHandler(true)
        }
        completeAction.backgroundColor = UIColor(hex: "187afe")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.switchStates.removeValue(forKey: indexPath)
            self.numberOfItems -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    

}

extension UseSegmentedControlView{
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    @objc func addTableCell(){
        
        numberOfItems += 1
        firstTableView.reloadData()
        print("여깃지롱 ! ")
    }
    
    @objc func deleteAllCell() {
        if seconTableView.numberOfRows(inSection: 0) == 0 {
            showAlert(title: "삭제할 항목 없음", message: "삭제할 항목이 없습니다.")
        } else {
            showConfirmationAlert(title: "삭제 확인", message: "모든 항목을 삭제하시겠습니까?")
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              let row = textField.tag as Int? else {
            return
        }
        updateText(text, for: IndexPath(row: row, section: 0))
    }
    
    @objc func switchDidChange(_ sender: UISwitch) {
        let isSwitchOn = sender.isOn
        
        if let cell = sender.superview?.superview as? UITableViewCell,
           let _ = firstTableView.indexPath(for: cell),
           let textField = cell.viewWithTag(123) as? UITextField {
            
            if !isSwitchOn {
                let attributedText = NSAttributedString(string: textField.text ?? "", attributes: [
                    NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.strikethroughColor: UIColor.black
                ])
                textField.attributedText = attributedText
            } else {
                let attributedText = NSAttributedString(string: textField.text ?? "")
                textField.attributedText = attributedText
            }
        }
    }
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
