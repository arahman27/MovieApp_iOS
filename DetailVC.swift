//
//  DetailVC.swift
//  A3_Aditya_Rahman

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    var mov_img = ""
    var mov_title = ""
    var mov_year = 0
    var mov_id = ""
    var mov_type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: mov_img)
        posterImgView.load(url: url!)
        
        titleLbl.text = mov_title
        yearLbl.text = "Year: " + String(mov_year)
        idLbl.text = "IMDB ID: " + mov_id
        typeLbl.text = "Type(s): " + mov_type
        
    }
}

extension UIImageView {
    func load(url: URL){
        DispatchQueue.global().async{ [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
