//
//  PrevPgae.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/01.
//
import UIKit



class PrevPage: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        func M (yPosition: CGFloat){
        //label
        //A:스페이싱 적용 - 실패
        //Q:스페이싱이 적용되고 나면 함수 재사용도 UI에 드러날까?
                    
                let M = UILabel()
                M.text = "내 이름은 M 이다"
                M.textColor = .black
                M.font = .systemFont(ofSize: 20)
                M.textAlignment = .center
                
                view.addSubview(M)
                
                
                M.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([M.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                                            ]) //좌우중앙정령
                
                //   M.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)])
                //  ↑ 이렇게 되면 y축 위치가 한곳으로 포인팅이 되서 모든 label이 한자리에 출력됨.
                //  따라서  아래와↓ 같이 작성해서  spacing으로 개별요소의 위치를 지정해줄수있어야한다.
                //  문득 드는생각 | 이렇게 할게 아니라 가장 가까운 요소를 기준으로 얼마 간격을 주고 위치하게 되면 해결되는 문제 아닐까 ?
                
               
                NSLayoutConstraint.activate([M.topAnchor.constraint(equalTo: view.topAnchor, constant: yPosition)])
    
   
        }
        // 재사용성공 .. 🥹
        M(yPosition: 100)
        M(yPosition: 500)
        
        //imageView
        //A:사이즈 설정 필요!! 조절이 안됨 ..
        let IMG = UIImageView()
        let contents = UIImage(systemName: "square.and.arrow.down")        //이미지가 안나왔던 이유 systemName이 오류
        IMG.image = contents
        IMG.contentMode = .scaleAspectFit
        self.view.addSubview(IMG)
        
        
        
        IMG.translatesAutoresizingMaskIntoConstraints = false // 역할 : 부모뷰의 크기에 따라서 자식뷰의 크기나 위치나 영향을 받는 것을. true/false로 하겠다. 잘 활용하면 반응형 대응이 가능하겠는데 ? 근데 내 경우는 왜 true로 했을때 이미지가 안나오지 ? 부모쪽에도 대응이 필요한건가 ?
        NSLayoutConstraint.activate([IMG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     //topAnchor -> centerYAnchor
                                     IMG.centerYAnchor.constraint(equalTo:
                                                                    self.view.topAnchor, constant: 200),
        IMG.widthAnchor.constraint(equalToConstant: 100),   // 사이즈 지정
          IMG.heightAnchor.constraint(equalToConstant: 100)
                                    ])
        
        
        
        // self.view 의 위치를 조정하면 error가 생기는 이유는 ?
        //textField
        let textField = UITextField()
        textField.placeholder = "나와라얍"
        self.view.addSubview(textField)
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     textField.centerYAnchor.constraint(equalTo:
                                                                            self.view.topAnchor, constant: 300)])
        
        
        //prev랑 next button에 border 주고싶다...
        
        //2
//        M()
 
        
    }
}
