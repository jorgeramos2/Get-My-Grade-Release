//
//  Actividad.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit

class Actividad: Codable {
    var nombre: String = ""
    var calificacion: Int = 0
    var id : Int = 0
    var idCategoria: Int = 0
    var ponderacion: Int = 0
    init(nombre:String,calificacion:Int,id:Int,idCategoria: Int,ponderacion: Int)
    {
        self.nombre=nombre
        self.calificacion=calificacion
        self.id=id
        self.idCategoria=idCategoria
        self.ponderacion=ponderacion
    }
}
