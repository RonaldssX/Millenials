//
//  Answer.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation

final class AnsweredQuestion: Decodable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case playerAnswer, multiplier
    }
    
    weak var player: Player?
    weak var question: Question? 
    
    var extraData: [String: Any] = [:]
    
    var playerAnswer: String?
    var hasAnswered: Bool {
        get { return (playerAnswer != nil && !playerAnswer!.isEmpty) }
    }
    private var answeredCorrectlyStore: Bool = false
    var answeredCorrectly: Bool {
        get {
            if let question = question {
                answeredCorrectlyStore = (playerAnswer == question.correctAnswer)
            }
            return answeredCorrectlyStore
        }
    }
    private var multiplier: Int = 1
    private var pointsEarnedStore: Int = 0
    var pointsEarned: Int {
        get {
            if let question = question {
                pointsEarnedStore = (question.value * multiplier)
            }
            return pointsEarnedStore
        }
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.playerAnswer = try? values.decodeIfPresent(String.self, forKey: .playerAnswer)
        self.multiplier = try values.decode(Int.self, forKey: .multiplier)
        //self.extraData = try values.decode(Dictionary<String, Any>.self, forKey: .extraData)
    }
    
    init() {
        
    }
    
    init(playerAnswer: String? = nil, multiplier: Int, additionalData: [String: Any]? = nil) {
        self.configure(with: playerAnswer, multiplier: multiplier, additionalData: additionalData)
    }
    
    func configure(with answer: String?, multiplier: Int, additionalData: [String: Any]?) {
        self.playerAnswer = answer
        self.multiplier = multiplier
        self.extraData = (additionalData != nil) ? additionalData! : self.extraData
    }
    
    static public func == (lhs: AnsweredQuestion, rhs: AnsweredQuestion) -> Bool { return lhs.playerAnswer == rhs.playerAnswer && lhs.pointsEarned == rhs.pointsEarned }
    public func hash(into hasher: inout Hasher) { for property in [playerAnswer as AnyHashable, pointsEarned as AnyHashable] { hasher.combine(property) } }
    
}
