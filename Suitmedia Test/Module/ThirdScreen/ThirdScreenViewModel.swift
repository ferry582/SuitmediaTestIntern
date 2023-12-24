//
//  ThirdScreenViewModel.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 24/12/23.
//

import Foundation

class ThirdScreenViewModel {
    private let apiService = APIService()
    
    var listUsers: Observable<[User]> = Observable([])
    var isRefreshing: Observable<Bool> = Observable(false)
    var totalPage = 1
    
    func removeAllListUsers() {
        self.isRefreshing.value = true
        listUsers.value?.removeAll()
        self.isRefreshing.value = false
    }
    
    func getUserList(page: Int) async { //tambahin async
        self.isRefreshing.value = true
        
        do {
            let result = try await apiService.getListUsers(page: page)
            self.totalPage = result.totalPages
            
            if page <= self.totalPage {
                self.listUsers.value?.append(contentsOf: self.mapUserResponseToModel(from: result))
            }
            
            print("total fetch page \(page): \(result.data.count)")
        } catch {
            print(error.localizedDescription)
        }
        
        self.isRefreshing.value = false
    }
    
    private func mapUserResponseToModel(from response: UserResponse) -> [User] {
        var result = [User]()
        
        for data in response.data {
            result.append(User(email: data.email, firstName: data.firstName, lastName: data.lastName, avatar: URL(string: data.avatar)))
        }
        
        return result
    }
}
