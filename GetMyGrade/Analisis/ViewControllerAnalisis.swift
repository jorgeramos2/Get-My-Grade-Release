//
//  ViewControllerAnalisis.swift
//  GetMyGrade
//
//  Created by user158430 on 11/5/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerAnalisis: UIViewController,UITextFieldDelegate,UIViewControllerTransitioningDelegate {
     // MARK: - Variables y Outlets
    var listaMaterias = [Materia]()
    var listaCategorias = [Categoria]()
    var listaActividades = [Actividad]()
    var matAnalisis : Materia!
    var calif: CGFloat = 0
    var idMat : Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var countFired: CGFloat = 0
    var resultado: String!
    var num: Int!
    let transition = CircularTransition()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var tfMeta: UITextField!
      // MARK: - DataFileUrl
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Materias.plist")
        return pathArchivo
    }
    func dataFileUrl2() -> URL {
           let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
           let pathArchivo = url.appendingPathComponent("Categorias.plist")
           return pathArchivo
       }
    func dataFileUrl3() -> URL {
           let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
           let pathArchivo = url.appendingPathComponent("Actividades.plist")
           return pathArchivo
       }
    
     // MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tfMeta.becomeFirstResponder()
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        // Do any additional setup after loading the view.
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaMaterias = try PropertyListDecoder().decode([Materia].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        do {
                  let data = try Data.init(contentsOf: dataFileUrl2())
                  listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
              }
              catch {
                  print("Error reading or decoding file")
              }
        do {
                  let data = try Data.init(contentsOf: dataFileUrl3())
                  listaActividades = try PropertyListDecoder().decode([Actividad].self, from: data)
              }
              catch {
                  print("Error reading or decoding file")
              }
        encontrarMateria()
        califBar()
       
        
    }
 // MARK: -Encontrar la materia que se esta analizando
func encontrarMateria()
{
    var i = 0
         while (listaMaterias.count > i){

             if (listaMaterias[i].id == idMat){
                 matAnalisis = listaMaterias[i]
             }
                            
         i += 1
         }
}
func puntosExtra() -> Int
{
  var puntos = 0
  var i = 0
 var acum = 0
   
    while (listaCategorias.count > i)
    {
    var j = 0
    
        if(matAnalisis.id == listaCategorias[i].idMateria && listaCategorias[i].diffPond == true)
        {
            
            while(listaActividades.count > j)
            {
                if(listaCategorias[i].id == listaActividades[j].idCategoria)
                {
                    acum += listaActividades[j].ponderacion
                   
                }
                j += 1
            }
            puntos += (acum * listaCategorias[i].ponderacion)/100
        }
        i += 1
    }
   
  return puntos
}
 // MARK: -Progress Bar
 func califBar()
 {
    calif = CGFloat(Double(matAnalisis.calificacion) * 0.01)
    if(calif>0)
    {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
          self.countFired += 1
          
          DispatchQueue.main.async {
            self.progressBar.progress = min(0.03 * self.countFired, self.calif)
            
            if self.progressBar.progress == self.calif {
              timer.invalidate()
            }
          }
        }
    }
    else
    {
          DispatchQueue.main.async {
            self.progressBar.progress = min(0.0 * self.countFired, self.calif)
          }
        
    }
  }
 // MARK: -Hacer analisis
@IBAction func HacerAnalisis(_ sender: UIButton) {

    let meta = Int(tfMeta.text!)
    
        if meta == 0 || meta == nil {
            tfMeta.shake()
        }
        else{
            if meta! <= matAnalisis.calificacion {
                
                resultado = "Congratulations! You already achieved your goal !"
                num = 1
            }
                
            else {
                
                let puntosParaMeta = meta! - matAnalisis.calificacion
                let puntosRestantes = matAnalisis.total - matAnalisis.ponderacion + puntosExtra()
                
                if puntosRestantes < puntosParaMeta {
                    resultado = "We are sorry, with the remaning course points its imposible to achieve your goal"
                    num = 2
                 
                }
                else{
                    let prom = (puntosParaMeta * 100)/puntosRestantes
                    resultado = "On the remaining assignments of the course you need an average of " + String(prom) + " to reach your goal "
                    num = 3
                }
            }
        }
    }
    
    // MARK: - Navigation y animacion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ViewControllerResultadosAnalisis
         secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        secondVC.mostrar = resultado
        secondVC.numFoto = num
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let meta = Int(tfMeta.text!)
        if meta == 0 || meta == nil {
            return false
        }
        
            return true
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
  
    
    
    // MARK: - Restringir rotacion
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
    return false
    }
}
