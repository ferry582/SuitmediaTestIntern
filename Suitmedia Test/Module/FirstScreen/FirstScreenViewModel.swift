//
//  FirstScreenViewModel.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import Foundation

class FirstScreenViewModel {
    var palindromeMessage: Observable<String> = Observable("")

    func isPalindrome(text: String){
        guard !text.isEmpty else {
            palindromeMessage.value = "Palindrom Textfield is empty!"
            return
        }
        
        let textNoSpaces = text.filter{!$0.isWhitespace}
        let characters = Array(textNoSpaces.lowercased())
        var start = 0
        var end = characters.count - 1
        
        while start < end  {
            if characters[start] != characters[end]  {
                palindromeMessage.value = "\"\(text)\" is not palindrome"
                return
            }
            start += 1
            end -= 1
        }
        palindromeMessage.value = "\"\(text)\" is palindrome"
    }
}
