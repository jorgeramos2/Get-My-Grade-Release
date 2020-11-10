//
//  Materia.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit

class Materia: Codable {
    var nombre: String = ""
    var id: Int = 0
    var calificacion: Int = 0
    var ponderacion: Int = 0
    var total: Int = 100
    init(nombre:String,id:Int,calificacion:Int, ponderacion:Int,total:Int)
    {
        self.nombre=nombre
        self.id=id
        self.calificacion=calificacion
        self.ponderacion = ponderacion
        self.total = total
    }
}
