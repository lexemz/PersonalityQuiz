//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Alexey Efimov on 30.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
    // 1. Передать сюда массив с ответами
    // 2. Определить наиболее часто встречающийся тип животного
    // 3. Отобразить результат в соответствии с этим животным
    // 4. Избавиться от кнопки возврата на предыдущий экран
    @IBOutlet var resultTitle: UILabel!
    @IBOutlet var resultDescription: UILabel!

    var answersChosen: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: true)

        printResult()
    }

    private func identifyAnimal() -> Animal? {
        let animalDuplicates = Dictionary(
            grouping: answersChosen.map { $0.animal },
            by: { $0 }
        ).filter { $1.count > 1 }.keys

        answersChosen.forEach { print($0.animal) }
        
        // если частое животное одно, его и возвращаем
        if animalDuplicates.isEmpty {
            return answersChosen.first?.animal
        }
        
        // если частых животных >1, ищем первое упомянутое животное среди дубликатов
        for answer in answersChosen {
            if animalDuplicates.contains(answer.animal) {
                return answer.animal
            }
        }

        return nil
    }
    
    private func printResult() {
        if let animal = identifyAnimal() {
            resultTitle.text = "Вы - \(animal.rawValue)"
            resultDescription.text = animal.definition
        }
    }
}
