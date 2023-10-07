//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Hanami Do on 10/6/23.
//

import Foundation

class TriviaQuestionService {
    // closure receives a TriviaQuestions data model
    static func fetchTriviaQuestions(                                 completion: (([CurrentTriviaQuestion]) -> Void)? = nil) {
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
                    print(questions)
                    completion?(questions)  // call the completion closure and pass in the response
                }
            }
            catch {
                // handle error gracefully
                print("Error decoding JSON: \(error)")
            }// at this point, `data` contains data received from the response
        }
        task.resume()  // resume the task and fire the request
    }
    
//    // closure receives a CurrentTriviaQuestion data model
//    static func fetchTriviaQuestion(questionIndex: Int,
//                                    completion: ((CurrentTriviaQuestion) -> Void)? = nil) {
//        let url = URL(string: "https://opentdb.com/api.php?amount=10")
//        // create a data task & pass in the URL
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            // this closure is fired when the response is received
//            guard error == nil else {
//                assertionFailure("Error: \(error!.localizedDescription)")
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                assertionFailure("Invalid response")
//                return
//            }
//            guard let data = data, httpResponse.statusCode == 200 else {
//                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
//                return
//            }
//            let decoder = JSONDecoder()
//            // performs the actual decoding of data
//            do {
//                let response = try decoder.decode(TriviaAPIResponse.self, from: data)
//                print(response.results)
//                DispatchQueue.main.async {  // dispatches the enclosed code block to main queue, so all UI work done on main thread
//                    // closure called after decoding is complete
//                    completion?(response.results[questionIndex])  // call the completion closure and pass in the response
//                }
//            }
//            catch {
//                // handle error gracefully
//                print("Error decoding JSON: \(error)")
//            }// at this point, `data` contains data received from the response
//        }
//        task.resume()  // resume the task and fire the request
//    }
    
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
