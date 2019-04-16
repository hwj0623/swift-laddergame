//
//  InputView.swift
//  LadderGame
//
//  Created by hw on 15/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

/// 입력값이 숫자인지 체크 - 1)빈문자열이 아니고, 2)정수숫자가 있어야하고, 3)다른 문자열이 없어야 한다
private extension String {
    func isNumber() -> Bool {
        return !self.isEmpty
            && self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
            && self.rangeOfCharacter(from: CharacterSet.letters) == nil
    }
}
/// 메시지 프로토콜
protocol PrintMessage {
    var printInputMessage: String {get}
    var printUnitRangeMessage: String {get}
}

enum ValidRangeCode: Int {
    case validMarginalInputNumberSize = 2
    case maxInputNumberSize = 20
}

struct InputView {
    private (set) var ladderMap: [[Bool]]
    
    init(){
        ladderMap = [[Bool]]()
    }
    
    internal mutating func startLadderGame() throws -> Void {
        var ladderGame: LadderGame = LadderGame()
        printPeopleMessage()
        try inputPlayerHandle(&ladderGame)
        printLaddersMessage()
        try inputLadderHandle(&ladderGame)
        
        ladderGame.initLadder()
        ladderMap = ladderGame.buildLadder()
        
        printLadder(ladder2dMap: ladderMap)
    }
    
    /// private functions
    private struct initialValueState {
        static let defaultNumericState: Int = -1
        static let defaultInputState: String = ""
    }
    
    private func checkValidInput() throws -> String{
        guard let input: String = readLine() else{ throw ErrorCode.invalidInput }
        return input
    }
    
    private func checkValidNumber(_ inputString: String) throws -> Int {
        if !inputString.isNumber(){
            throw ErrorCode.notANumber
        }
        if let integerValue = Int (inputString){
            return integerValue
        }
        throw ErrorCode.notANumber
    }
    private func checkValidRange(_ number: Int) throws -> Int {
        if number < ValidRangeCode.validMarginalInputNumberSize.rawValue ||
            number > ValidRangeCode.maxInputNumberSize.rawValue  {
            throw ErrorCode.outOfRangeNumber
        }
        return number
    }
    private func inputErrorHandle() throws -> Int {
        var input: String = initialValueState.defaultInputState
        var number: Int = initialValueState.defaultNumericState
        input = try checkValidInput()
        number = try checkValidNumber(input)
        number = try checkValidRange(number)
        return number
    }
    
    private func inputPlayerHandle(_ ladderGame: inout LadderGame) throws -> Void {
        let input: String  = try checkValidInput()
        let playerList = input.split(separator: ",")
        
        for player in playerList {
            let ladderPlayer = LadderPlayer(String(player))
            ladderGame.names.append(ladderPlayer)
        }
        ladderGame.numberOfPlayers = ladderGame.names.count
    }
    
    private func inputLadderHandle(_ input: inout LadderGame) throws -> Void {
        input.height = try inputErrorHandle()
    }
    
    private func printPeopleMessage() -> Void {
        let peopleInfo: PeopleInfo = PeopleInfo()
        print(peopleInfo.printInputMessage)
        print(peopleInfo.printUnitRangeMessage)
    }
    
    private func printLaddersMessage() -> Void {
        let laddersInfo: LaddersInfo = LaddersInfo()
        print(laddersInfo.printInputMessage)
        print(laddersInfo.printUnitRangeMessage)
    }
    
    private struct PeopleInfo : PrintMessage {
        var printInputMessage: String {
            get{
                return "참여할 사람은 모두 몇 명입니까?"
            }
        }
        var printUnitRangeMessage: String{
            get{
                return "콤마(,)로 구분하여 이름을 나열해주세요\n( ex: khan,faker,teddy,mata,clid )\n"
            }
        }
    }
    
    private struct LaddersInfo : PrintMessage {
        var printInputMessage: String{
            get{
                return "\n최대 사다리 높이는 몇 개 입니까?"
            }
        }
        var printUnitRangeMessage: String{
            get{
                return "2이상 20이하의 자연수 입력\n"
            }
        }
    }
}









