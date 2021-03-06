//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Alexey Efimov on 30.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultTitle: UILabel!
    @IBOutlet var resultDescription: UILabel!

    var answersChosen: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: false)

        updateUI()
    }

    private func updateUI() {
        guard let findedAnimal = identifyAnimal() else { return }
        resultTitle.text = "Вы - \(findedAnimal.rawValue)"
        resultDescription.text = findedAnimal.definition
    }

    private func identifyAnimal() -> Animal? {
        let countedSet = NSCountedSet(array: answersChosen.map { $0.animal })
        let mostFrequent = countedSet.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
        guard let findedAnimal = mostFrequent as? Animal else { return nil }
        return findedAnimal
    }
}
