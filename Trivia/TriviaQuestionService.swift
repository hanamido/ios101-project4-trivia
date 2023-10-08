//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Hanami Do on 10/6/23.
//

import Foundation

class TriviaQuestionService {
    // closure receives a CurrentTriviaQuestion data model
    static func fetchTriviaQuestions(                         completion: (([CurrentTriviaQuestion]) -> Void)? = nil) {
        // let parameters = "amount=10&"
        let url = URL(string: "https://opentdb.com/api.php?amount=10")
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
                let response = try decoder.decode(TriviaAPIResponse.self, from: data)
                DispatchQueue.main.async {  // dispatches the enclosed code block to main queue, so all UI work done on main thread
                    // closure called after decoding is complete
                    let questions = response.results
                    completion?(questions)  // call the completion closure and pass in the response
                }
            }
            catch {
                // handle error gracefully
                print("Error decoding JSON: \(error)")
            } // at this point, `data` contains data received from the response
        }
        task.resume()  // resume the task and fire the request
    }
    
    static func fetchTriviaQuestionByCategory(categoryId: Int,      completion: (([CurrentTriviaQuestion]) -> Void)? = nil) {
        let parameters = "category=\(categoryId)"
        let url = URL(string: "https://opentdb.com/api.php?amount=10&\(parameters)")
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
                let response = try decoder.decode(TriviaAPIResponse.self, from: data)
                DispatchQueue.main.async {  // dispatches the enclosed code block to main queue, so all UI work done on main thread
                    // closure called after decoding is complete
                    let questions = response.results
                    completion?(questions)  // call the completion closure and pass in the response
                }
            }
            catch {
                // handle error gracefully
                print("Error decoding JSON: \(error)")
            } // at this point, `data` contains data received from the response
        }
        task.resume()  // resume the task and fire the request
    }
    
    private static func parse(data: Data) -> CurrentTriviaQuestion {
        // transform the data we received into a dictionary [String: Any]
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let currentCategory = jsonDictionary["category"] as! String
        let currentType = jsonDictionary["type"] as! String
        let currentDifficulty = jsonDictionary["difficulty"] as! String
        let currentQuestion = jsonDictionary["question"] as! String
        let correctAnswer = jsonDictionary["correct_answer"] as! String
        let incorrectAnswers = jsonDictionary["incorrect_answer"] as! [String]
        return CurrentTriviaQuestion(category: currentCategory,
                                     type: currentType,
                                     difficulty: currentDifficulty,
                                     question: currentQuestion,
                                     correctAnswer: correctAnswer,
                                     incorrectAnswers: incorrectAnswers)
    }
}

extension String {
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
}
