//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Hanami Do on 10/7/23.
//

import UIKit

class CategoriesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // number of columns in the picker view
    func numberOfComponents(in categoriesPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // return number of rows based on data source
    func pickerView(_ categoriesPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let numCategories = self.categories.count
        return numCategories
    }
    
    // provides the title for each row based on data source
    func pickerView(_ categoriesPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categoriesArray[row]
    }
    
    // respond to user selection
    func pickerView(_ categoriesPickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = categoriesArray[row]
        self.categoryId = self.getIdFromCategory(categoryName: selectedValue)
    }
    
    @IBOutlet weak var categoryInstructionsButton: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        print("category button pressed")
        performSegue(withIdentifier: "ShowTriviaViewController", sender: self)
        
//        let viewControllerToPush = TriviaViewController()
//        navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerViewHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryPickerViewVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryPickerViewLeadingCosntraint: NSLayoutConstraint!
    @IBOutlet weak var categoryPickerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryPickerViewTopConstraint: NSLayoutConstraint!
    
    
    private var categories: [CurrentCategory] = [CurrentCategory]()
    private var categoriesArray: [String] = [String]()
    private var categoriesDictionary: [Int: String] = [Int: String]()
    var categoryId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        categoriesPickerView.delegate = self
        categoriesPickerView.dataSource = self
        categoriesPickerView.isHidden = false
        categoryInstructionsButton.numberOfLines = 0  // allow unlimited lines for text wrapping
        categoryInstructionsButton.textAlignment = .center
        let categoryButtonWidth: CGFloat = 280
        let xPosition = (view.frame.width - categoryButtonWidth) / 2
        categoryInstructionsButton.frame = CGRect(x: xPosition, y: 250, width: 280, height: 100)
        
        // Fetch the categories available from API
        TriviaCategoriesService.fetchCategories(completion: {(triviaCategories) in
            self.categories = triviaCategories
            print(self.categories)
            self.getAllCategories()
            self.categoriesPickerView.dataSource = self
            self.categoriesPickerView.reloadAllComponents()
        })
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowTriviaViewController" {
            if let destinationVC = segue.destination as? TriviaViewController {
                destinationVC.categoryId = self.categoryId
            }
        }
    }
    
    private func getAllCategories() -> Void {
        self.categoriesArray.append("Random Categories")
        for category in categories {
            let id = category.id
            let name = category.name
            self.categoriesDictionary[id] = name
            self.categoriesArray.append(category.name)
        }
        print(self.categoriesArray)
    }
    
    private func getIdFromCategory(categoryName: String) -> Int {
        for (key, value) in categoriesDictionary {
            if value == categoryName {
                return key
            }
        }
        return 0
    }
    
    private func addGradient() {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = view.bounds
      gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                              UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
      view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
