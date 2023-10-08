//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
    
  private var questions = [CurrentTriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
    var categoryId: Int? = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
    // TODO: FETCH TRIVIA QUESTIONS HERE
      if categoryId == 0 {
          TriviaQuestionService.fetchTriviaQuestions(completion: { (triviaQuestions) in
              print(self.categoryId ?? 0)
              self.questions = triviaQuestions
              self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
          })
      }
      else {
          TriviaQuestionService.fetchTriviaQuestionByCategory(categoryId: categoryId ?? 0, completion: { (triviaQuestions) in
              print(self.categoryId ?? 0)
              self.questions = triviaQuestions
              self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
          })
      }
  }
    
    @IBAction func goToCategoriesButtonTapped(_ sender: UIButton) {
        if let categoriesViewController = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") {
            present(categoriesViewController, animated: true, completion: nil)
        }
    }
  
    private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
      let question = questions[questionIndex]
        let questionText = String(htmlEncodedString: question.question)
      questionLabel.text = questionText
      categoryLabel.text = question.category
    let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
        if question.type == "boolean" {
            answerButton0.setTitle(answers[0], for: .normal)
            answerButton0.isHidden = false
            answerButton1.setTitle(answers[1], for: .normal)
            answerButton1.isHidden = false
            answerButton2.isHidden = true
            answerButton3.isHidden = true
        }
        else {
            if answers.count > 0 {
                let answer0Text = String(htmlEncodedString: answers[0])
                answerButton0.setTitle(answer0Text, for: .normal)
            }
            if answers.count > 1 {
                let answer1Text = String(htmlEncodedString: answers[1])
                answerButton1.setTitle(answer1Text, for: .normal)
                answerButton1.isHidden = false
            }
            if answers.count > 2 {
                let answer2Text = String(htmlEncodedString: answers[2])
                answerButton2.setTitle(answer2Text, for: .normal)
                answerButton2.isHidden = false
            }
            if answers.count > 3 {
                let answer3Text = String(htmlEncodedString: answers[3])
                answerButton3.setTitle(answer3Text, for: .normal)
                answerButton3.isHidden = false
            }
        }
  }

  private func updateToNextQuestion(answer: String) {
      let isCorrectBool: Bool = isCorrectAnswer(answer)
    if isCorrectBool {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
      print(currQuestionIndex)
      guard currQuestionIndex < questions.count else {
        showFinalScore()
        return
      }
    showFeedbackAlert(with: isCorrectBool)
      updateQuestion(withQuestionIndex: currQuestionIndex)
  }

  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
    
    private func showFeedbackAlert(with isCorrectBool: Bool) -> Void {
        if isCorrectBool {
            let correctController = UIAlertController(title: "Correct: ",
                                                    message: "You currently have: \(numCorrectQuestions)/\(questions.count) correct",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok",
                                         style: .default,
                                         handler: nil)
            correctController.addAction(okAction)
            present(correctController, animated: true, completion: nil)
        } else {
            let incorrectController = UIAlertController(title: "Incorrect: ",
                                                    message: "You currently have: \(numCorrectQuestions)/\(questions.count) correct",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok",
                                         style: .default,
                                         handler: nil)
            incorrectController.addAction(okAction)
            present(incorrectController, animated: true, completion: nil)
        }

    }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
        TriviaQuestionService.fetchTriviaQuestions(completion: { (triviaQuestions) in
            self.questions = triviaQuestions
            self.currQuestionIndex = 0
            self.numCorrectQuestions = 0
            self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
        })
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
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
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

