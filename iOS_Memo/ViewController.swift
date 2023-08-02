//
//  ViewController.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/07/31.
//

import UIKit

class ViewController: UIViewController {
 
    
    
    // 무얼 덮어쓴다는걸까 ?
    // 화면이 로드 되었을때 필요한 초기화 작업을 수행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   
        let button = UIButton(type: .system)
        button.setTitle("버튼이다", for: .normal)
        button.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
//        button.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
                                    ])
        
        //make one more
        let choco = UIButton(type: .system)
        choco.setTitle("나는 초코다", for: .normal)
        choco.addTarget(self,action: #selector(pushViewController),for: .touchUpInside)
//         choco.frame = CGRect(x: 200, y: 500, width: 200, height: 200)
        choco.setTitleColor(.red, for: .normal)
        self.view.addSubview(choco)
        
        choco.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([choco.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            choco.centerYAnchor.constraint(equalTo:
                                            self.view.topAnchor, constant: 400)])
       
        
    }

    
    @objc func pushViewController(){
        let newViewController = UIViewController()
        newViewController.title = "다음페이지"
        newViewController.view?.backgroundColor = .white
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
    //화면이 나타나기전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2.viewWillAppear")
        
        
    }
    //화면이 나타난 후
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3.viewDidAppear")
    }
    
    //다른 화면으로 이동하기 전에
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4.viewWillDisappear")
           }
    
    //화면으로 이동한후 -> 그다음에 처리할게 있나 ?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5.viewDidDisappear")
    }
    
    
}
    
          



