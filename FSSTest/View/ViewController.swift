//
//  ViewController.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import UIKit

class ViewController: UIViewController {
    // UI Properties
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var indicatorview: UIActivityIndicatorView!
    
    // ViewModel object
    var dataArray: [Recipe] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Recipes"
        
        // Initially TableView is hidden
        dataTableView.isHidden = true
        
        // Creating ViewModel object
        var dvm = DataViewModel()
        
        // Setting view model delegate
        dvm.delegate = self
        
        // Make an API Call
        showLoader()
        dvm.getAPICall(urlStr: "https://dummyjson.com/recipes")
        
        // Setting tableView
        dataTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
    }
    
    func showAlert(errorStr: String){
        let alert = UIAlertController(title: title, message: errorStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showLoader(){
        indicatorview.isHidden = false
        indicatorview.startAnimating()
    }
    
    func hideHider(){
        indicatorview.isHidden = true
        indicatorview.stopAnimating()
        indicatorview.hidesWhenStopped = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecipeTableViewCell
        = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell") as! RecipeTableViewCell
        cell.updateUI(details: dataArray[indexPath.row])
        cell.recipeImageView.image = UIImage(named: "placeholder")  //set placeholder image first.
        cell.recipeImageView.downloadImageFrom(link: dataArray[indexPath.row].image ?? "", contentMode: UIView.ContentMode.scaleAspectFit)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let str = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        nextVC.recipeDetails = dataArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ViewController: DataDelegate{
    
    func didReceiveSuccess(response: detailsResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideHider()
            self.dataTableView.isHidden = false
            self.dataArray =  response?.recipes ?? []
            print(self.dataArray[0].name ?? "")
            self.dataTableView.reloadData()
        }
    }
    
    func didReceiveFailure(error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideHider()
            self.showAlert(errorStr: error ?? "Something went wrong. Please try again after sometime")
        }
    }
}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
