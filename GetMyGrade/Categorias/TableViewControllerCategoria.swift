//
//  TableViewControllerCategoria.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit

class TableViewControllerCategoria: UITableViewController, protocoloAgregaCategoria {
    // MARK: - Variables
    var idMateria: Int!
    var nomMateria: String!
    var listaCategorias = [Categoria]()
    var listaActividades = [Actividad]()
    var listaCategoriasMostrar = [Categoria]()
    // MARK: - Guardar archivos
    func guardaCategorias() {
        actualizarCalif()
        do {
           let data = try PropertyListEncoder().encode(listaCategorias)
           try data.write(to: dataFileUrl())
        }
        catch {
           print("Save Failed")
        }
    }
    func guardaActividades() {
          
          do {
             let data = try PropertyListEncoder().encode(listaActividades)
             try data.write(to: dataFileUrl2())
          }
          catch {
             print("Save Failed")
          }
      }
    func agregaCategoria(cat: Categoria) {
        listaCategorias.append(cat)
        listaCategoriasMostrar.append(cat)
        actualizarCalif()
        tableView.reloadData()
        
    }
    // MARK: - DataFileUrls
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categorias.plist")
        return pathArchivo
    }
    
    func dataFileUrl2() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Actividades.plist")
        return pathArchivo
    }
    func leerArchivos()
    {
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl2())
            listaActividades = try PropertyListDecoder().decode([Actividad].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
    }
    // MARK: - viewDidload and will
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = nomMateria + " - Categories"
        leerArchivos()
        actualizarCalif()
        actualizarCategorias()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leerArchivos()
        actualizarCalif()
        actualizarCategorias()
        guardaCategorias()
        tableView.reloadData()
    }
    
    // MARK: - Agregar a arreglo temporal
    func actualizarCategorias () -> Void
    {
       
        if(listaCategoriasMostrar.count>0)
        {
            listaCategoriasMostrar.removeAll()
        }
        var i = 0
        while (listaCategorias.count > i)
        {
            if(listaCategorias[i].idMateria == idMateria)
            {
              let cat = listaCategorias[i]
                listaCategoriasMostrar.append(cat)
            }
        i+=1
        }
        
    }
    // MARK: - Editar ponderacion
    @IBAction func Editar(_ sender: UIButton) {
        setEditing(false, animated: true)
        let alert = UIAlertController(title: "Edit Percentage", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField(configurationHandler: { (textField) in
        textField.placeholder = "Write a new Percentage"})
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(ACTION) in alert.dismiss(animated: true, completion: nil)}))
        
        let submitAction = UIAlertAction(title: "Accept", style: .default) { [unowned alert] _ in
            let pond_Nueva = Int(alert.textFields![0].text!)
            
        var x = 0
            while x < self.listaCategorias.count{
                
                if self.listaCategorias[x].id == sender.tag {
                    self.listaCategorias[x].ponderacion = pond_Nueva!
                }
            
                x += 1
            }
            
            self.guardaCategorias()
            self.tableView.reloadData()
        }
            
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actualizar calificacion
    func actualizarCalif() {
        var i = 0
        var j = 0
        var suma = 0
        var cont = 0
        var verificaion = true
        while (listaCategorias.count > i){
            j = 0
            suma = 0
            cont = 0
           	 while (listaActividades.count > j) {
                
                    if (listaCategorias[i].id == listaActividades[j].idCategoria && listaCategorias[i].diffPond == false){
                        suma += listaActividades[j].calificacion
                        cont += 1
                   }
                    else if (listaCategorias[i].id == listaActividades[j].idCategoria && listaCategorias[i].diffPond == true)
                    {
                        suma += (listaActividades[j].calificacion * listaActividades[j].ponderacion / 100)
                        verificaion = false
                    }
                
                j += 1
            }
            
            if cont != 0 && verificaion == true{
                suma = suma / cont
            }
            listaCategorias[i].calificacion = suma
           
            
            i += 1
        }
    }
   
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        
        return listaCategoriasMostrar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellCategoria
            cell.lbNombre.text=listaCategoriasMostrar[indexPath.row].nombre
        
        if(listaCategoriasMostrar[indexPath.row].calificacion == 0)
        {
            cell.lbCalif.text = "0" + " / " + String(listaCategoriasMostrar[indexPath.row].ponderacion)
        }
        else
        {
            cell.lbCalif?.text = String((listaCategoriasMostrar[indexPath.row].calificacion*listaCategoriasMostrar[indexPath.row].ponderacion)/100) + " / " + String(listaCategoriasMostrar[indexPath.row].ponderacion)
        }
        
        cell.btEditar.tag = listaCategoriasMostrar[indexPath.row].id

        return cell
    }
    
   
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // MARK: - Borrar
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            borrarCategorias(idCat: listaCategoriasMostrar[indexPath.row].id)
            borrarActividades(idCat: listaCategoriasMostrar[indexPath.row].id)
            listaCategoriasMostrar.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        guardaActividades()
        guardaCategorias()
    }
    func borrarCategorias(idCat:Int)
    {
        var i=0
        while(i<listaCategorias.count)
        {
            if(idCat==listaCategorias[i].id)
            {
               listaCategorias.remove(at: i)
            }
            i+=1
        }
    }
    func borrarActividades(idCat:Int)
      {
          var i=0
          while(i<listaActividades.count)
          {
              if(idCat==listaActividades[i].idCategoria)
              {
                 listaActividades.remove(at: i)
              }
              i+=1
          }
      }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="footer")
        {
            let viewAgregar = segue.destination as! ViewControllerAgregaCategoria
            viewAgregar.delegado = self
            viewAgregar.idMateria = idMateria
            setEditing(false, animated: true)
        }
        else
        {
            let vistaActividad = segue.destination as! TableViewControllerActividad
            let indexPath = tableView.indexPathForSelectedRow!
            vistaActividad.idCategoria = listaCategoriasMostrar[indexPath.row].id
            vistaActividad.nomMateria = nomMateria
            vistaActividad.nomCategoria = listaCategoriasMostrar[indexPath.row].nombre
        }
    }
   // MARK: - Restringir rotacion
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.landscape
      }
      override var shouldAutorotate: Bool {
      return false
      }
}
