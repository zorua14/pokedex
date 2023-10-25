//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Karthikeyan Muthu on 16/10/23.
//
import CoreData
import Foundation
import UIKit

@MainActor
class PokemonViewModel{
    
    private var context:NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    enum Status{
        case notStarted
        case fetching
        case success
        case failure(error: Error)
    }
    @Published private(set) var status = Status.notStarted
    
    private let controller:FetchController
    
    init(controller:FetchController){
        self.controller = controller
        Task{
            await getPokemon()
        }
    }
    
   private func getPokemon() async{
        status = .fetching
       if !hasPokemon(){
           do{
               var pokedex = try await controller.fetchAllPokemon()
               pokedex.sort {$0.id < $1.id}
               for pokemon in pokedex {
                   let newpokemon = Pokemon(context: context)
                   newpokemon.id = Int16(pokemon.id)
                   newpokemon.name = pokemon.name
                   newpokemon.types = pokemon.types
                   newpokemon.hp = Int16(pokemon.hp)
                   newpokemon.attack = Int16(pokemon.attack)
                   newpokemon.specialAttack = Int16(pokemon.specialAttack)
                   newpokemon.defense = Int16(pokemon.defense)
                   newpokemon.specialDefense = Int16(pokemon.specialDefense)
                   newpokemon.speed = Int16(pokemon.speed)
                   newpokemon.sprite = pokemon.sprite
                   newpokemon.shiny = pokemon.shiny
                   newpokemon.favourite = false
                   
                   try context.save()
               }
               status = .success
           }
           catch{
               status = .failure(error: error)
           }
       }
    }
    func getAllData() -> [Pokemon] {
        var pokemons: [Pokemon] = []
        do{
            pokemons = try context.fetch(Pokemon.fetchRequest())
        }
        catch{
            print("Error fetching from coredata",error)
        }
        
        return pokemons
    }
    func hasPokemon() -> Bool{
        var data:[Pokemon] = []
        do{
            data = try context.fetch(Pokemon.fetchRequest())
            //count == limit set by you
            if data.count>1{
                return true
            }
            else{
                return false
            }
        }
        catch{
            return false
        }
    }
}
