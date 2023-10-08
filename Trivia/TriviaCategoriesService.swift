//
//  TriviaCategoriesService.swift
//  Trivia
//
//  Created by Hanami Do on 10/7/23.
//

import Foundation

class TriviaCategoriesService {
    // closure receives a CurrentCategory data model
    static func fetchCategories(                                 completion: (([CurrentCategory]) -> Void)? = nil) {
        // let parameters = "amount=10&"
        let url = URL(string: "https://opentdb.com/api_category.php")
        // create a data task & pass in the URL
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            let decoder = JSONDecoder()
            // performs the actual decoding of data
            do {
                let response = try decoder.decode(CategoriesAPIResponse.self, from: data)
                DispatchQueue.main.async {  // dispatches the enclosed code block to main queue, so all UI work done on main thread
                    // closure called after decoding is complete
                    let categories = response.triviaCategories
                    completion?(categories)  // call the completion closure and pass in the response
                }
            }
            catch {
                // handle error gracefully
                print("Error decoding JSON: \(error)")
            } // at this point, `data` contains data received from the response
        }
        task.resume()  // resume the task and fire the request
    }
}
