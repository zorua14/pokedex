//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Karthikeyan Muthu on 18/10/23.
//

import UIKit
import Charts
class PokemonDetails: UIViewController {

    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var shiny: UIButton!
    
    var changed = false
    var barChartView: BarChartView!
    var pokemon = Pokemon()
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor.black.cgColor

        // Add corner radius to the view
        cardView.layer.cornerRadius = 30.0
        cardView.layer.masksToBounds = true
        name.text = pokemon.name!.capitalized
        image.addImage(pokemon.sprite!)
        barChartView = BarChartView()
        barChartView.frame = CGRect(x: 0, y: cardView.frame.height - 250, width: cardView.frame.width, height: 200)
        cardView.addSubview(barChartView)
        
        // Call a function to set up the chart data and properties
        setupChart(pokemon)
    }
    
    func setupChart(_ poke: Pokemon) {
           
        let entries: [BarChartDataEntry] = [
            BarChartDataEntry(x: 0, y: Double(poke.hp), data: "HP"),
            BarChartDataEntry(x: 1, y: Double(poke.attack), data: "Attack"),
            BarChartDataEntry(x: 2, y: Double(poke.specialAttack), data: "Sp.Atk"),
            BarChartDataEntry(x: 3, y: Double(poke.defense), data: "Defense"),
            BarChartDataEntry(x: 4, y: Double(poke.specialDefense), data: "Sp.Def"),
            BarChartDataEntry(x: 5, y: Double(poke.speed), data: "Speed")
           ]

        // Configure the data set
        let dataSet = BarChartDataSet(entries: entries, label: "\(poke.name!.capitalized)'s stats")
        dataSet.colors = ChartColorTemplates.material()
        // Set labels for bars
        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
        dataSet.valueTextColor = .black
        dataSet.valueFormatter = DefaultValueFormatter(formatter: NumberFormatter())

        // Configure the chart data
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
    
    }
    
    @IBAction func shinyBtn(_ sender: Any) {
        if changed == false{
            changed.toggle()
            image.addImage(pokemon.shiny!)
        }else{
            changed.toggle()
            image.addImage(pokemon.sprite!)
        }
        
    }
    
}
