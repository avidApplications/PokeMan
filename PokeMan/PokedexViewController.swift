//
//  PokedexViewController.swift
//  PokeMan
//
//  Created by Bradley Stovall on 5/26/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var caughtPokeMans : [PokeMan] = []
    
    var uncaughtPokeMans : [PokeMan] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let pokeman = PokeMan(context: context)
        pokeman.name = "test"
        pokeman.imageName = "mew"
        pokeman.caught = true
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        */
        
        caughtPokeMans = getAllCaughtPokeMans()
        uncaughtPokeMans = getAllUncaughtPokemans()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    // PokeMan Lists
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
        } else {
            return "UNCAUGHT"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokeMans.count
        } else {
            return uncaughtPokeMans.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokeman : PokeMan
        if indexPath.section == 0 {
            pokeman = caughtPokeMans[indexPath.row]
        } else {
            pokeman = uncaughtPokeMans[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = pokeman.name
        cell.imageView?.image = UIImage(named:pokeman.imageName!)
        return cell
    }
    
    
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
