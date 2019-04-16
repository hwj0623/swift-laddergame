//
//  main.swift
//  LadderGame
//
//  Created by JK on 09/10/2017.
//  Copyright © 2017 Codesquad Inc. All rights reserved.
//
//  Forked and dev by HW on 09/04/2019
import Foundation

// khan,clid,faker,teddy,mata
let main = {
    while true {
        do {
            try startLadderGame()
            break;
        }catch ErrorCode.invalidInput{
            print("입력이 없습니다")
        }catch ErrorCode.notANumber{
            print("입력 문자열은 숫자가 아닙니다.")
        }catch ErrorCode.outOfRangeNumber{
            print("입력 범위가 유효한 범위가 아닙니다.")
        }catch {
            print("알 수 없는 에러 발생")
        }
    }
}

main()
