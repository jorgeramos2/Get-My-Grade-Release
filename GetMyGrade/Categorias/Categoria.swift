//
//  Categoria.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit

class Categoria: Codable {
    var nombre: String = ""
    var ponderacion: Int = 0
    var id: Int = 0
    var idMateria: Int = 0
    var calificacion: Int = 0
    var diffPond: Bool = false
    init(nombre:String,ponderacion:Int,id:Int,idMateria: Int,calificacion:Int,diffPond:Bool)
    {
        self.nombre=nombre
        self.ponderacion=ponderacion
        self.id=id
        self.idMateria=idMateria
        self.calificacion=calificacion
        self.diffPond=diffPond
    }

}
