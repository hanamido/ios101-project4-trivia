//
//  CurrentTriviaQuestion.swift
//  Trivia
//
//  Created by Hanami Do on 10/6/23.
//

import Foundation

struct CurrentTriviaQuestion: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.category = try container.decode(String.self, forKey: .category)
//        self.type = try container.decode(String.self, forKey: .type)
//        self.difficulty = try container.decode(String.self, forKey: .difficulty)
//        self.question = try container.decode(String.self, forKey: .question)
//        self.correct_answer = try container.decode(String.self, forKey: .correct_answer)
//        self.incorrect_answers = try container.decode([String].self, forKey: .incorrect_answers)
//    }
    
    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case type = "type"
        case difficulty = "difficulty"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

// stores the API response, since the data we need is in the key <results>
struct TriviaAPIResponse: Decodable {
    let results: [CurrentTriviaQuestion]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

