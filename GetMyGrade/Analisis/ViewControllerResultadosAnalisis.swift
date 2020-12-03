//
//  ViewControllerResultadosAnalisis.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerResultadosAnalisis: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var label1: UILabel!
    var mostrar: String!
    var numFoto :Int!
    override func viewDidLoad() {
        super.viewDidLoad()
         dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
         label1.text = mostrar
        //elegirImagen()
    }
    
    @IBAction func dismissSecondVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*func elegirImagen()
    {
        if(numFoto==1)
        {
            imagen.image = UIImage(named: "happy.png")
        }
        if(numFoto==2)
        {
            imagen.image = UIImage(named: "sdoggo.jpg")
        }
        if(numFoto==3)
        {
            imagen.image = UIImage(named: "tdoggo.png")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
