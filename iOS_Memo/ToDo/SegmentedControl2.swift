//
//  SegmentedControl.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/10.
//

import UIKit


class SegmentedControl2:UIViewController{
    
    var numberOfItems = 3 // initial number of rows
    var switchStates: [IndexPath: Bool] = [:] // Dictionary to store UISwitch states for each cell
    
    
    //세그먼트컨트롤
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Todo", "Complete"])
         let font = UIFont.systemFont(ofSize: 30)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
      }()
      let firstView: UIView = {
        let view = UIView()
//        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
      let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
      
      var shouldHideFirstView: Bool? {
        didSet {
          guard let shouldHideFirstView = self.shouldHideFirstView else { return }
          self.firstView.isHidden = shouldHideFirstView
          self.secondView.isHidden = !self.firstView.isHidden
        }
      }
    //라벨
    let label: UILabel = {
           let label = UILabel()
           label.text = "firstView 안의 레이블"
           label.font = UIFont.systemFont(ofSize: 20)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
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
        
        addButton.addTarget(self, action: #selector(addTableCell), for:.touchUpInside)
        return addButton
    }()
    
    //테이블뷰
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
      
      override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)
//        self.firstView.addSubview(label)
          self.firstView.addSubview(addButton)
          self.firstView.addSubview(tableView)
          tableView.dataSource = self
                tableView.delegate = self
          
        //세그먼트 컨트롤
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
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
  
          //라벨
//          NSLayoutConstraint.activate([
//                     label.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
//                     label.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor),
//                 ])
//          self.firstView.addSubview(label)
          
          //추가하기 버튼
          NSLayoutConstraint.activate([
              addButton.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
              addButton.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
              addButton.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
              addButton.heightAnchor.constraint(equalToConstant: 50)
          ])
 

          
          //테이블뷰
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
              tableView.leadingAnchor.constraint(equalTo: self.firstView.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: self.firstView.trailingAnchor),
              tableView.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor),
          ])
          
          // Register cell class or nib if needed
          tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
      }
    


    
      @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
      }
    
    @objc func addTableCell(){
   
        numberOfItems += 1
        tableView.reloadData()
        print("여깃지롱 ! ")
    }
 }



extension SegmentedControl2: UITableViewDelegate, UITableViewDataSource {
    
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
        if let cell = tableView.cellForRow(at: indexPath) {
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
           let indexPath = tableView.indexPath(for: cell),
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
