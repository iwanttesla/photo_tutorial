//
//  ViewController.swift
//  photo_tutorial
//
//  Created by OCUBE on 2022/12/13.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var profileChangeBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //이 viewcontroller에 profileimage를 명확하게 하려면 self를 붙여야함
        self.profileImage.layer.cornerRadius = profileImage.frame.height / 2
        self.profileChangeBtn.layer.cornerRadius = 10
        self.profileImage.contentMode = .scaleAspectFill
        
        //버튼클릭 액션 설정
        self.profileChangeBtn.addTarget(self, action: #selector(onProfileChangeBtnClicked), for: .touchUpInside)
        
    }
    
    //프사 변경 버튼이 클릭되었을때
    @objc fileprivate func onProfileChangeBtnClicked(){
        print("프사바꾸기 버튼을 누름")
        
        // 카메라 라이브러리 세팅
        var config = YPImagePickerConfiguration()
//        config.screens = [.library, .photo,.video]
        config.screens = [.library]
        
        let picker = YPImagePicker(configuration: config)
        
        //사진이 선택되었을때
        picker.didFinishPicking { [unowned picker] items, _ in
            
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                //프사 이미지를 변경한다. (클로저에 있을때는 self를 사용해야함.)
                self.profileImage.image = photo.image
            }
            //피커창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        //사진선택창 보여주기
        present(picker, animated: true, completion: nil)
        
    }
}

