import UIKit

class TodoListPage: UIViewController {
    
    var segmentedControl: UISegmentedControl!
    
    @IBOutlet var tableView: UITableView!
//    var tavleView: UITableView
    
    var numberOfItems = 2 // initial number of rows
    var switchStates: [IndexPath: Bool] = [:] // Dictionary to store UISwitch states for each cell
    
    @IBAction func TodoButton(_ sender: UIButton) {
        // Implementation of action for TodoButton
    }
    
    @IBAction func CompleteButton(_ sender: UIButton) {
        // Implementation of action for CompleteButton
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        numberOfItems += 1
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        
        func setupUI() {
            // Create and configure segmented control
            segmentedControl = UISegmentedControl(items: ["Todo", "Comlete"])
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(segmentedControl)
            
            
            // Set segmented control constraints
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
                segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            // Create and configure table view
            tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            
            // Set table view constraints
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            // Register cell class or nib if needed
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        }
    }
}




extension TodoListPage: UITableViewDelegate, UITableViewDataSource {
    
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
        toggle.onTintColor = .blue
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
        completeAction.backgroundColor = UIColor.blue
        
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

