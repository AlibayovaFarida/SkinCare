//
//  DetectProblemViewController.swift
//  Skincare-app
//
//  Created by Umman on 12.08.24.
//

import UIKit

class DetectProblemViewController: UIViewController {
    
    var action: (() -> Void)?
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let contentViewInScroll: UIView = {
        let view = UIView()
        return view
    }()
    
    private let formStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 28
        sv.alignment = .leading
        return sv
    }()
    
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
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Müəyyən et", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        button.backgroundColor = UIColor(named: "customLightGreen")
        button.layer.cornerRadius = 23
        button.clipsToBounds = true
        return button
    }()
    
    private var selectedAnswers: [Int: AnswerBoxView] = [:]
    private var answeredQuestions: Set<Int> = []
    
    private func createQuestionView(questionText: String, answers: [String], questionIndex: Int) -> UIView {
        let questionView = UIStackView()
        questionView.axis = .vertical
        questionView.spacing = 8
        questionView.alignment = .leading
        
        let questionStackView = UIStackView()
        questionStackView.axis = .horizontal
        questionStackView.spacing = 8
        questionStackView.alignment = .leading
        
        let questionLabel = UILabel()
        questionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        questionLabel.textColor = UIColor(named: "customBlack")
        questionLabel.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: questionText)
        let starAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(named: "threatening_red") ?? UIColor.red
        ]
        let starString = NSAttributedString(string: " *", attributes: starAttributes)
        attributedString.append(starString)
        
        questionLabel.attributedText = attributedString
        
        questionStackView.addArrangedSubview(questionLabel)
        
        let answerBoxStackView = UIStackView()
        answerBoxStackView.axis = .horizontal
        answerBoxStackView.spacing = 12
        answerBoxStackView.alignment = .leading
        
        answers.forEach { answerText in
            let answerBox = AnswerBoxView(answerText: answerText)
            answerBoxStackView.addArrangedSubview(answerBox)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(answerBoxTapped(_:)))
            answerBox.addGestureRecognizer(tapGesture)
        }
        
        [questionStackView, answerBoxStackView].forEach(questionView.addArrangedSubview)
        
        return questionView
    }
        
    @objc private func answerBoxTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedBox = gesture.view as? AnswerBoxView else { return }
        guard let questionView = tappedBox.superview?.superview as? UIStackView else { return }
        
        guard let questionIndex = formStackView.arrangedSubviews.firstIndex(of: questionView) else { return }
        
        handleAnswerSelection(answerBox: tappedBox, for: questionIndex)
    }
    
    private func handleAnswerSelection(answerBox: AnswerBoxView, for questionIndex: Int) {
        if let previouslySelected = selectedAnswers[questionIndex], previouslySelected != answerBox {
            previouslySelected.handleTap()
        }
        
        answerBox.handleTap()
        
        if answerBox.isSelected {
            selectedAnswers[questionIndex] = answerBox
            answeredQuestions.insert(questionIndex)
        } else {
            selectedAnswers.removeValue(forKey: questionIndex)
            answeredQuestions.remove(questionIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCustomBackButton()
        setupGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "customWhite")
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(formStackView)
        view.addSubview(infoButton)
        view.addSubview(submitButton)
        
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        formStackView.addArrangedSubview(titleLabel)
        
        let questionsAndAnswers: [(question: String, answers: [String])] = [
            ("1. Təmizlədikdən sonra dərinizdə necə bir hiss yaranır?", ["Sıx və quru", "Sıx və quru", "Yağlı və ya parıltılı"]),
            ("2. Dərinizdə nə qədər tez-tez qırışlar və ya ləkələr yaranır?", ["Heç vaxt", "Sıx və quru", "Tez-tez"]),
            ("3. Dəriniz günəşə necə reaksiya verir?", ["Yanır, həssasdır", "Sıx və quru", "Mülayim"]),
            ("4. Dərinizin quruluşu necədir?", ["İncə məsaməli", "Orta məsaməli", "Çox məsaməli"]),
            ("5. Nəmləndirici tətbiq etdikdən bir neçə saat sonra dəriniz necə hiss edir?", ["Nəmlənmiş", "Yağlı", "Həssas"])
        ]
        
        questionsAndAnswers.enumerated().forEach { index, qa in
            let questionView = createQuestionView(questionText: qa.question, answers: qa.answers, questionIndex: index)
            formStackView.addArrangedSubview(questionView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentViewInScroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        formStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
        }
        
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(120)
            make.height.equalTo(44)
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

    private func setupGesture() {
        let infoButtonLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleInfoButtonLongPress))
        infoButtonLongPressGesture.minimumPressDuration = 0
        infoButtonLongPressGesture.cancelsTouchesInView = false
        infoButton.addGestureRecognizer(infoButtonLongPressGesture)
        
        let submitButtonLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleSubmitButtonLongPress))
        submitButtonLongPressGesture.minimumPressDuration = 0
        submitButtonLongPressGesture.cancelsTouchesInView = false
        submitButton.addGestureRecognizer(submitButtonLongPressGesture)
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
    
    @objc private func handleSubmitButtonLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateSubmitButton(scale: 0.9)
        case .ended, .cancelled:
            animateSubmitButton(scale: 1.0)
        default:
            break
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
    
    private func animateInfoButton(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.infoButton.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    private func animateSubmitButton(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.submitButton.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    private func animateBackButton(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.navigationItem.leftBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }

    
    @objc private func infoButtonTapped() {
        print("Info button tapped")
    }
    
    @objc private func submitButtonTapped() {
        if answeredQuestions.count < 5 {
            let alert = UIAlertController(title: "Bildiriş", message: "Zəhmət olmasa bütün sualları cavablandırın.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            print("Submit button tapped")
            
        }
    }
}
