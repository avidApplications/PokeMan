//
//  CoreDataHelp.swift
//  PokeMan
//
//  Created by Bradley Stovall on 5/26/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit
import CoreData

func addAllPokeMan () {
    
    createPokeMan(name: "Mew", imageName: "mew")
    createPokeMan(name: "Meowth", imageName: "meowth")
    createPokeMan(name: "Abra", imageName: "abra")
    createPokeMan(name: "Pikachu", imageName: "pikachu-2")
    createPokeMan(name: "Snorlax", imageName: "snorlax")
    createPokeMan(name: "Squirtle", imageName: "squartle")
    createPokeMan(name: "Venonat", imageName: "venonat")
    createPokeMan(name: "Weedle", imageName: "weedle")
    createPokeMan(name: "Zubat", imageName: "zubat")
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}
// Make PokeMan
func createPokeMan(name :String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokeman = PokeMan(context: context)
    pokeman.name = name
    pokeman.imageName = imageName
}

func getAllPokeMan() -> [PokeMan] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let pokemans = try context.fetch(PokeMan.fetchRequest()) as! [PokeMan]
        
        if pokemans.count == 0 {
            addAllPokeMan()
            return getAllPokeMan()
        }
        
        return pokemans
    } catch {}
    
    return []
}

func getAllCaughtPokeMans() -> [PokeMan] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = PokeMan.fetchRequest() as NSFetchRequest<PokeMan>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    do {
        let pokemans = try context.fetch(fetchRequest) as! [PokeMan]
        return pokemans
    } catch {}
    return []
}

func getAllUncaughtPokemans() -> [PokeMan] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = PokeMan.fetchRequest() as NSFetchRequest<PokeMan>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    do {
        let pokemans = try context.fetch(fetchRequest) as! [PokeMan]
        return pokemans
    } catch {}
    return []
}

