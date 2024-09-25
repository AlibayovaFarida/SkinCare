//
//  DetectProblemViewController.swift
//  Questionnaire
//
//  Created by Umman on 25.09.24.
//

import UIKit
import SnapKit

struct Question {
    let text: String
    let answers: [String]
}

class DetectProblemViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.textColor = UIColor(named: "customBlack")
        label.text = "Dəri tipini müəyyən et"
        label.textAlignment = .center
        return label
    }()
    
    private let infoButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "info")
        configuration.imagePadding = 0
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    private let questions: [Question] = [
        Question(text: "1. Təmizlədikdən sonra dərinizdə necə bir hiss yaranır?", answers: ["Yağlı", "Quru", "Normal"]),
        Question(text: "2. Dərinizdə nə qədər tez-tez qırışlar və ya ləkələr yaranır?", answers: ["Tez-tez", "Heç vaxt", "Arabir"]),
        Question(text: "3. Dəriniz günəşə necə reaksiya verir?", answers: ["Nadir hallarda yanır", "Yanır, həssasdır", "Mülayim"]),
        Question(text: "4. Dərinizin quruluşu necədir?", answers: ["Çox məsaməli", "İncə məsaməli", "Orta məsaməli"]),
        Question(text: "5. Nəmləndirici tətbiq etdikdən bir neçə saat sonra dəriniz necə hiss edir?", answers: ["Yağlı", "Həssas", "Nəmlənmiş"])
    ]
    
    private var selectedAnswers: [Int?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "customWhite")
        self.hidesBottomBarWhenPushed = true
        selectedAnswers = Array(repeating: nil, count: questions.count)

        setupScrollView()
        setupTitleLabel()
        setupQuestionsAndAnswers()
        setupInfoButton()
        setupSubmitButton()
        setupCustomBackButton()
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView)
                make.width.equalTo(scrollView) // This is important to avoid scrolling issues
                make.bottom.equalToSuperview() // Ensures the content view expands to fit all subviews
            }
    }
    
    
    @objc private func infoButtonTapped() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = infoViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 16
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        
        present(infoViewController, animated: true, completion: nil)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).inset(20)
        }
    }

    private func setupInfoButton() {
        contentView.addSubview(infoButton)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleInfoButtonLongPress(_:)))
        infoButton.addGestureRecognizer(longPressGesture)

        infoButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }

    
    private func setupCustomBackButton() {
        guard let backButtonImage = UIImage(named: "back-button") else {
            print("Error: Back button image not found.")
            return
        }
                
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let backButtonLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleBackButtonLongPress))
        backButtonLongPressGesture.minimumPressDuration = 0
        backButtonLongPressGesture.cancelsTouchesInView = false
        backButton.addGestureRecognizer(backButtonLongPressGesture)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
                
        backButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
    
    @objc private func didTapBackButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.navigationItem.leftBarButtonItem?.customView?.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationItem.leftBarButtonItem?.customView?.alpha = 1.0
            }) { _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func handleBackButtonLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateBackButton(scale: 0.9)
        case .ended, .cancelled:
            animateBackButton(scale: 1.0)
        default:
            break
        }
    }
    
    @objc private func handleInfoButtonLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateInfoButton(scale: 0.9)
        case .ended, .cancelled:
            animateInfoButton(scale: 1.0)
        default:
            break
        }
    }
    
    private func animateInfoButton(scale: CGFloat) {
           UIView.animate(withDuration: 0.1, animations: {
               self.infoButton.transform = CGAffineTransform(scaleX: scale, y: scale)
           })
       }
    
    private func animateBackButton(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.navigationItem.leftBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }

    private func setupQuestionsAndAnswers() {
        var previousQuestionView: UIView? = titleLabel

        for (index, question) in questions.enumerated() {
            let questionView = createQuestionView(question: question, questionIndex: index)
            contentView.addSubview(questionView)

            // Debug log to confirm view addition
            print("Adding question view for: \(question.text)")
            
            questionView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(contentView).inset(20)
                if let previous = previousQuestionView {
                    make.top.equalTo(previous.snp.bottom).offset(28)
                } else {
                    make.top.equalTo(contentView).offset(20)
                }
            }

            previousQuestionView = questionView
        }

        if let lastQuestionView = previousQuestionView {
            lastQuestionView.snp.makeConstraints { make in
                make.bottom.equalTo(contentView).offset(-100) // Leave space for submit button
            }
        }
    }
    


    private func createQuestionView(question: Question, questionIndex: Int) -> UIView {
        let questionView = UIStackView()
        questionView.axis = .vertical
        questionView.spacing = 8
        questionView.alignment = .leading

        // Create the question label
        let questionLabel = UILabel()
        questionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        questionLabel.textColor = UIColor(named: "customBlack")
        questionLabel.numberOfLines = 0

        // Create an attributed string for the question
        let attributedString = NSMutableAttributedString(string: question.text)
        
        // Define attributes for the asterisk
        let starAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(named: "threatening_red") ?? UIColor.red
        ]
        let starString = NSAttributedString(string: " *", attributes: starAttributes)

        // Append the asterisk to the question label
        attributedString.append(starString)
        questionLabel.attributedText = attributedString

        // Create the answer stack view
        let answerStackView = UIStackView()
        answerStackView.axis = .horizontal
        answerStackView.spacing = 12
        answerStackView.alignment = .leading

        // Add answer buttons
        for (answerIndex, answerText) in question.answers.enumerated() {
            let answerButton = createAnswerButton(title: answerText, tag: questionIndex * 10 + answerIndex)
            answerStackView.addArrangedSubview(answerButton)
        }

        // Add the question label and answer stack view to the question view
        questionView.addArrangedSubview(questionLabel)
        questionView.addArrangedSubview(answerStackView)

        return questionView
    }


    

    private func createAnswerButton(title: String, tag: Int) -> UIButton {
        let answerButton = UIButton()
        answerButton.setTitle(title, for: .normal)
        answerButton.setTitleColor(.black, for: .normal)
        answerButton.layer.borderWidth = 1
        answerButton.layer.borderColor = UIColor.lightGray.cgColor
        answerButton.layer.cornerRadius = 15
        answerButton.tag = tag
        
        // Set the font size for the answer text
        answerButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14) // Change the size as needed
        
        answerButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        answerButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        answerButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        answerButton.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
        return answerButton
    }


    private func setupSubmitButton() {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Müəyyən et", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        submitButton.backgroundColor = UIColor(named: "customLightGreen")
        submitButton.layer.cornerRadius = 23
        submitButton.clipsToBounds = true
        
        contentView.addSubview(submitButton)
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-20) // Adjusted for consistent spacing
            make.bottom.equalTo(contentView).inset(20)
            make.height.equalTo(44)
            make.width.equalTo(120)
        }
        
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    }

    @objc private func answerSelected(_ sender: UIButton) {
        let questionIndex = sender.tag / 10
        let answerIndex = sender.tag % 10
     
        selectedAnswers[questionIndex] = answerIndex
        
        if let stackView = sender.superview as? UIStackView {
            for button in stackView.arrangedSubviews {
                if let button = button as? UIButton {
                    button.layer.borderColor = UIColor.lightGray.cgColor
                    button.backgroundColor = UIColor.white
                    button.setTitleColor(.black, for: .normal)
                }
            }
        }

        sender.backgroundColor = UIColor(named: "customDarkBlue")
        sender.setTitleColor(.white, for: .normal)
    }

    @objc private func handleSubmit() {
        let answeredCount = selectedAnswers.compactMap { $0 }.count
        
        if answeredCount < 5 {
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa bütün sualları cavablandırın.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            let result = calculateResult()
            let completeTestVC = CompleteTestViewController()
            completeTestVC.resultText = result
            navigationController?.pushViewController(completeTestVC, animated: true)
        }
    }

    private func calculateResult() -> String {
        var countColumn2 = 0
        var countColumn3 = 0

        for answer in selectedAnswers {
        
            guard let answerIndex = answer else { continue }
            if answerIndex == 1 {
                countColumn2 += 1
            } else if answerIndex == 2 {
                countColumn3 += 1
            }
        }

        if countColumn2 >= 3 {
            return "Qurudur"
        } else if countColumn3 >= 3 {
            return "Yağlıdır"
        } else {
            return "Qarışıqdır"
        }
    }

}

