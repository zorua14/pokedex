//
//  ViewController.swift
//  Pokedex
//
//  Created by Karthikeyan Muthu on 16/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearch: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    
    private var viewmodel = PokemonViewModel(controller: FetchController())
    var tableData:[Pokemon] = []
    var actualData:[Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //TRY IT IN VIEW WILL APPEAR
        actualData = viewmodel.getAllData()
        tableData = actualData
        tableview.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableview.dataSource = self
        tableview.delegate = self
    }
    
}
//MARK: - IMAGE EXTENSION

extension UIImageView{
    func addImage(_ imageUrl: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
//MARK: - TABLEVIEW EXTENSIONS

extension ViewController: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        let details = tableData[indexPath.row]
        //remove previous data
        cell.pokeImage.image = nil
        cell.pokeName.text = ""
        cell.typeOneText.text = ""
        cell.typeTwoText.text = ""
        cell.typeOne.backgroundColor = UIColor.clear
        cell.typeTwo.backgroundColor = UIColor.clear
        
        //
        cell.pokeImage.addImage(details.sprite!)
        cell.pokeName.text = details.name?.capitalized
        let types = details.types
        cell.typeOneText.text = types![0].capitalized
        cell.typeOne.layer.backgroundColor = UIColor(named: types![0].capitalized)?.cgColor
        if types!.count == 2{
            cell.typeTwo.layer.backgroundColor = UIColor(named: types![1].capitalized)?.cgColor
            cell.typeTwoText.text = types![1].capitalized
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PokemonDetails") as! PokemonDetails
        //vc.data nu ethaachu
        vc.pokemon = tableData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            tableData = actualData
            tableview.reloadData()
        }
        else{
            tableData = actualData.filter({($0.name!.capitalized.contains(searchText))})
            tableview.reloadData()
        }
    }
}
    

