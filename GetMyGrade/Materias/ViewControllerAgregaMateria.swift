//
//  ViewControllerAgregaMateria.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit
protocol protocoloAgregaMateria{
    func agregaMateria(mat:Materia)->Void
    func guardaMaterias()->Void
}
class ViewControllerAgregaMateria: UIViewController,UITextFieldDelegate{
    // MARK: - Variables y Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfTotal: UITextField!
    @IBOutlet var mySwitch: UISwitch!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var delegado: protocoloAgregaMateria!
   
     // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        self.tfNombre.delegate = self
        self.tfTotal.delegate = self
         tfNombre.addTarget(self, action: #selector(MyTextFielAction)
                               , for: UIControl.Event.primaryActionTriggered)
        
        mySwitch.addTarget(self, action: #selector(ViewControllerAgregaMateria.switchIsChanged(mySwitch:)), for: UIControl.Event.valueChanged)
        self.tfNombre.becomeFirstResponder()
        
        tfTotal.isHidden = true
        
        // cambiar color de los placeholder text
        tfNombre.attributedPlaceholder = NSAttributedString(string: "Math",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tfTotal.attributedPlaceholder = NSAttributedString(string: "105",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    // Do any additional setup after loading the view.
    }
     // MARK: - Guardar datos escritos
    @objc func MyTextFielAction(textField: UITextField) {
        let nom = tfNombre.text
        let total = tfTotal.text
        if nom != "" && tfTotal.isHidden == true
               {
                   let number = Int.random(in: 0 ... 1000)
                   let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion: 0,total: 100)
                   delegado.agregaMateria(mat: unaMat)
                   delegado.guardaMaterias()
                   navigationController?.popToRootViewController(animated: true)
               }
                else if(nom == "" && tfTotal.isHidden == true)
                    {
                    tfNombre.shake()
                    self.tfNombre.becomeFirstResponder()
                     
                    }
                else if(nom == "" && tfTotal.isHidden == false && total == "")
                    {
                    let alert = UIAlertController(title: "Missing values", message: "Both values are missing", preferredStyle: .alert)
                     let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                                           self.tfNombre.becomeFirstResponder()
                      }
                      alert.addAction(ok)
                     present(alert,animated: true,completion: nil)
                    }
            else if(nom == "" && tfTotal.isHidden == false && total != "")
                {
             tfNombre.shake()
             self.tfNombre.becomeFirstResponder()
                }
        else if(nom != "" && tfTotal.isHidden == false && total == "")
        {
            tfTotal.shake()
            self.tfTotal.becomeFirstResponder()
        }
        else if (nom != "" && tfTotal.isHidden == false && total != "")
        {
            let cali = Int(total!)!
            let number = Int.random(in: 0 ... 1000)
            let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion: 0,total: cali)
            delegado.agregaMateria(mat: unaMat)
            delegado.guardaMaterias()
            navigationController?.popToRootViewController(animated: true)
        }
    }
     // MARK: - Done del teclado
    @objc func analisis()->Void
    {
        let nom = tfNombre.text
        let total = tfTotal.text
        if nom != "" && tfTotal.isHidden == true
               {
                   let number = Int.random(in: 0 ... 1000)
                   let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion: 0,total: 100)
                   delegado.agregaMateria(mat: unaMat)
                   delegado.guardaMaterias()
                   navigationController?.popToRootViewController(animated: true)
               }
                else if(nom == "" && tfTotal.isHidden == true)
                    {
                    tfNombre.shake()
                    self.tfNombre.becomeFirstResponder()
                     
                    }
                else if(nom == "" && tfTotal.isHidden == false && total == "")
                    {
                    let alert = UIAlertController(title: "Missing values", message: "Both values are missing", preferredStyle: .alert)
                     let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                                           self.tfNombre.becomeFirstResponder()
                      }
                      alert.addAction(ok)
                     present(alert,animated: true,completion: nil)
                    }
            else if(nom == "" && tfTotal.isHidden == false && total != "")
                {
             tfNombre.shake()
             self.tfNombre.becomeFirstResponder()
                }
        else if(nom != "" && tfTotal.isHidden == false && total == "")
        {
            tfTotal.shake()
            self.tfTotal.becomeFirstResponder()
        }
        else if (nom != "" && tfTotal.isHidden == false && total != "")
        {
            let cali = Int(total!)!
            let number = Int.random(in: 0 ... 1000)
            let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion: 0,total: cali)
            delegado.agregaMateria(mat: unaMat)
            delegado.guardaMaterias()
            navigationController?.popToRootViewController(animated: true)
        }
    }
     // MARK: - Switch
    @objc func switchIsChanged(mySwitch: UISwitch) {
    if mySwitch.isOn {
        tfTotal.isHidden = false
        tfTotal.becomeFirstResponder()
       
    } else {
        tfTotal.isHidden = true
        tfNombre.becomeFirstResponder()
    }
}
   // MARK: - Llamar done
    func addDoneButtonOnKeyboard() {
                    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
                    doneToolbar.barStyle       = UIBarStyle.default
            let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(analisis))

                    var items = [UIBarButtonItem]()
                    items.append(flexSpace)
                    items.append(done)

                    doneToolbar.items = items
                    doneToolbar.sizeToFit()

                    self.tfTotal.inputAccessoryView = doneToolbar
                }

            @objc func doneButtonAction() {
                    self.tfTotal.resignFirstResponder()
                    /* Or:
                    self.view.endEditing(true);
                    */
                }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Restringir rotacion
override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
    return false
    }
}
