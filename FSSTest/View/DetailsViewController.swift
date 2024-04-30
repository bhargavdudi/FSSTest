//
//  DetailsViewController.swift
//  FSSTest
//
//  Created by Medshow on 01/05/24.
//

import UIKit

struct recipeDetailsss{
    var name: String
    var value: String
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailstableView: UITableView!
    
    var recipeDetails: Recipe?
    var recipeImage:UIImage?
    
    var details: [recipeDetailsss] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = recipeDetails?.name ?? ""
        
        detailstableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        detailstableView.register(UINib(nibName: "RecipeDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeDetailsTableViewCell")
        
        let ingredientsString = recipeDetails?.ingredients?.joined(separator: ",")
        
        details.append(recipeDetailsss(name: "", value: ""))
        details.append(recipeDetailsss(name: "ingredients", value: recipeDetails?.ingredients?.joined(separator: ",") ?? ""))
        details.append(recipeDetailsss(name: "instructions", value: recipeDetails?.instructions?.joined(separator: ",") ?? ""))
        details.append(recipeDetailsss(name: "Preperation Time", value: String("\(recipeDetails?.prepTimeMinutes ?? 0) mins")))
        details.append(recipeDetailsss(name: "Cook Time", value: String("\(recipeDetails?.cookTimeMinutes ?? 0) mins")))
        details.append(recipeDetailsss(name: "Servings", value: String("\(recipeDetails?.servings ?? 0) persons")))
        details.append(recipeDetailsss(name: "difficulty", value: recipeDetails?.difficulty ?? ""))
        details.append(recipeDetailsss(name: "cuisine", value: recipeDetails?.cuisine ?? ""))
        details.append(recipeDetailsss(name: "Calories", value: String(recipeDetails?.caloriesPerServing ?? 0)))
        details.append(recipeDetailsss(name: "tags", value: recipeDetails?.tags?.joined(separator: ",") ?? ""))
        details.append(recipeDetailsss(name: "ratinge", value: String(recipeDetails?.rating ?? 0)))
        details.append(recipeDetailsss(name: "review count", value: String(recipeDetails?.reviewCount ?? 0)))
        details.append(recipeDetailsss(name: "meal type", value: recipeDetails?.mealType?.joined(separator: ",") ?? ""))
        
        detailstableView.delegate = self
        detailstableView.dataSource = self
        detailstableView.reloadData()
        
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell: ImageTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
            cell.recipeImageView.image = UIImage(named: "placeholder")  //set placeholder image first.
            cell.recipeImageView.downloadImageFrom(link: recipeDetails?.image ?? "", contentMode: UIView.ContentMode.scaleAspectFill)
            return cell
        }else{
            let cell: RecipeDetailsTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsTableViewCell") as! RecipeDetailsTableViewCell
            cell.staticLabel.text = details[indexPath.row].name.capitalized
            cell.descLabel.text = details[indexPath.row].value
            cell.selectionStyle = .none
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else{
            return UITableView.automaticDimension
        }
    }
    
   
}
