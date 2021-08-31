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

    private func printResult() {
        if let animal = identifyAnimal() {
            resultTitle.text = "Вы - \(animal.rawValue)"
            resultDescription.text = animal.definition
        }
    }

    private func identifyAnimal() -> Animal? {
        let answersDuplicates = Dictionary(
            grouping: answersChosen.map { $0.animal },
            by: { $0 }
        ).filter { $1.count > 1 }

        /* Реализация данного приложения не предусматривает случаи, когда
         дубликаты ответов есть, но их количество разное.
         
         Например:
         если добавить ещё один вопрос, определяющий каким животным является пользователь,
         то количество дубликатов может быть >1 и
         один из дубликатов может встречаться чаще другого:
         
         [cat, rabbit, cat, rabbit, rabbit, dog]
         
         и cat и rabbit - несколько раз встречаются в ответах, поэтому нужен
         отсортированный по кол-ву дубликатов масив [rabbit, dog]. */
        let duplicatesDescendingOrder = answersDuplicates
            .sorted { $0.1.count > $1.1.count }
            .map { $0.0 }

        answersChosen.forEach { print($0.animal) }
        print()
        print(answersDuplicates.values)
        print()
        print(duplicatesDescendingOrder)

        // если дубликатов животных нет в ответах, возвращаем первый выбранный пользователем ответ
        if answersDuplicates.isEmpty {
            return answersChosen.first?.animal
        }

        // если есть дубликаты, ищем первое упомянутое животное среди дубликатов
        for answer in answersChosen {
            if duplicatesDescendingOrder.contains(answer.animal) {
                return answer.animal
            }
        }

        return nil
    }
}
