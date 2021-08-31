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

        /* Текущая реализация данного приложения не предусматривает случаи,
         когда дубликаты ответов есть, но их количество разное.
         
         На данный момент можно получить максимум 5 ответов, и 2 из которых
         будут иметь равное кол-во дубликатов (по 2 на каждый ответ)
         
         [dog, cat, dog, rabbit, cat]
         
         Если добавить ещё один вопрос, определяющий каким животным является
         пользователь, то количество дубликатов может быть >2 и
         один из дубликатов может встречаться чаще других:
         
         [cat, rabbit, cat, rabbit, rabbit, dog]
         и cat и rabbit - имеют дубликаты, но rabbit встречается чаще.
         
         Данный агоритм подходит для любого кол-ва ответов поэтому его работа
         реализована на отсортированном по кол-ву дубликатов масиве
         (прим: [rabbit, cat]). */
        let duplicatesDescendingOrder = answersDuplicates
            .sorted { $0.1.count > $1.1.count }
            .map { $0.0 }

        // если дубликатов животных нет в ответах, возвращаем первый выбранный пользователем ответ
        if answersDuplicates.isEmpty {
            return answersChosen.first?.animal
        }

        /* если есть дубликаты, ищем первое упомянутое животное среди дубликатов
        от более частого отвека к менее частому */
        for answer in answersChosen {
            if duplicatesDescendingOrder.contains(answer.animal) {
                return answer.animal
            }
        }

        return nil
    }
}
