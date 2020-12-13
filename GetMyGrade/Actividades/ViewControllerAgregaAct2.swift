//
//  ViewControllerAgregaAct2.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit
// MARK: - protocol
protocol protocoloAgregaActividad2{
func agregaActividad(act:Actividad)->Void
func guardaActividades()->Void
}
class ViewControllerAgregaAct2: UIViewController,UITextFieldDelegate {
    var idCategoria: Int!
    var delegado:protocoloAgregaActividad2!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCalificacion: UITextField!
    @IBOutlet weak var tfPonderacion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfNombre.delegate = self
        self.tfCalificacion.delegate = self
        self.tfPonderacion.delegate = self
        self.addDoneButtonOnKeyboard()
        self.addDoneButtonOnKeyboard2()
        tfNombre.becomeFirstResponder()
        
        // cambiar color de los placeholder text
        tfNombre.attributedPlaceholder = NSAttributedString(string: "Homework 1",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tfCalificacion.attributedPlaceholder = NSAttributedString(string: "85",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tfPonderacion.attributedPlaceholder = NSAttributedString(string: "25",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])        // Do any additional setup after loading the view.
    }
    // MARK: - Guardar datos escritos
    @objc func analisis()->Void
    {
        let nom = tfNombre.text
        let cal = Int(tfCalificacion.text!)
        let pond = Int(tfPonderacion.text!)
        if nom != "", cal != nil,pond != nil
        {
            if(cal!>100)
            {
            let alertController = UIAlertController(title: "Alerta", message: "You are adding a grade over 100", preferredStyle: .alert)
                       let cancelar = UIAlertAction(title: "Revert", style: .default) { (action) in
                                   
                       }
                           let aceptar = UIAlertAction(title: "Accept", style: .default){
                               (action) in
                               let number = Int.random(in: 0 ... 10000)
                               let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: self.idCategoria, ponderacion: 0)
                               self.delegado.agregaActividad(act: unAct)
                               self.delegado.guardaActividades()
                               self.navigationController?.popViewController(animated: true)
                           }
                       alertController.addAction(aceptar)
                       alertController.addAction(cancelar)
                       present(alertController,animated: true,completion: nil)
            }
            if cal!<=100
            {
               
                let number = Int.random(in: 0 ... 1000)
                let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: idCategoria,ponderacion: pond!)
                delegado.agregaActividad(act: unAct)
                delegado.guardaActividades()
                navigationController?.popViewController(animated: true)
            }
        }
        else if(nom == "" && cal == nil && pond == nil)
        {
            tfNombre.shake()
            tfCalificacion.shake()
            tfPonderacion.shake()
            tfNombre.becomeFirstResponder()
        }
       
        else if(nom != "" && cal != nil && pond == nil)
        {
            tfPonderacion.shake()
            tfPonderacion.becomeFirstResponder()
        }
        else if(nom == "" && cal != nil && pond != nil)
        {
            tfNombre.shake()
            tfNombre.becomeFirstResponder()
        }
        else if(nom != "" && cal == nil && pond != nil)
        {
            tfCalificacion.shake()
            tfCalificacion.becomeFirstResponder()
        }
       
        else
        {
            let alert = UIAlertController(title: "Missing values", message: "Some values are missing", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.tfNombre.becomeFirstResponder()
            }
            alert.addAction(ok)
            present(alert,animated: true,completion: nil)
        }
        }
    // MARK: - DONE Y NEXT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.switchBasedNextTextField(textField)
           return true
       }
       private func switchBasedNextTextField(_ textField: UITextField) {
           switch textField {
           case self.tfNombre:
               self.tfCalificacion.becomeFirstResponder()
           default:
               self.tfNombre.resignFirstResponder()
           }
       }
    @objc func moveResponder()->Void
    {
        self.tfPonderacion.becomeFirstResponder()
    }
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
    
                self.tfPonderacion.inputAccessoryView = doneToolbar
            }
     func addDoneButtonOnKeyboard2() {
                let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
                doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.done, target: self, action: #selector(moveResponder))
    
                var items = [UIBarButtonItem]()
                items.append(flexSpace)
                items.append(done)
    
                doneToolbar.items = items
                doneToolbar.sizeToFit()
    
                self.tfCalificacion.inputAccessoryView = doneToolbar
            }
    
        @objc func doneButtonAction() {
                self.tfPonderacion.resignFirstResponder()
             
                //self.view.endEditing(true);
                
            }
    // MARK: - Restringir rotacion
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.landscape
      }
      override var shouldAutorotate: Bool {
      return false
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
