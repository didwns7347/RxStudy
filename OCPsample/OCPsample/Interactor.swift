//
//  Interactor.swift
//  OCPsample
//
//  Created by yangjs on 2022/10/05.
//

import Foundation
import KeychainAccess

struct ColorModel{
    enum ColorType : String{
        case blue = "blue"
        case red = "red"
    }
    let color : ColorType
    var currentBlueColor: Int = 0
    var currentRedColor: Int = 0
}

//-MARK: keychain
public protocol KeychainRepository{
    func save(_ key:String, _ value : String)
    func get(_ key:String) -> String?
    func delete(_ key:String)
    func removeAll()
}

class KeychainRepositoryImpl : KeychainRepository{
    public static let shared = KeychainRepositoryImpl()
    private init() {}
    
    let keychain = Keychain()
    
    func save(_ key: String, _ value: String) {
        do{
            try keychain.set(value, key: key)
        }catch{
            print(error.localizedDescription)
            return
        }
    }
    
    func get(_ key: String) -> String? {
        do{
            guard let key = try keychain.get(key) else {return nil}
            return key
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func delete(_ key: String){
        do{
            try keychain.remove(key)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func removeAll(){
        do{
            try keychain.removeAll()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}


//MARK: Keychain Service
fileprivate struct KeychainKey{
    static let blueCount = "blueCount"
    static let redCount = "redCount"
}

protocol KeychainService{
    func saveBlueCount(_ count: Int)
    func saveRedCount(_ count: Int)
    
    func getBlueCount() -> Int?
    func getRedCount() -> Int?
}

class KeychainServiceImpl : KeychainService{
    private let keychainRepository : KeychainRepository
    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }
    
    func saveBlueCount(_ count: Int) {
        keychainRepository.save(KeychainKey.blueCount, "\(count)")
    }
    
    func saveRedCount(_ count: Int) {
        keychainRepository.save(KeychainKey.redCount, String(count))
    }
    
    func getBlueCount() -> Int? {
        return Int(keychainRepository.get(KeychainKey.blueCount) ?? "0")
    }
    
    func getRedCount() -> Int? {
        return Int(keychainRepository.get(KeychainKey.redCount) ?? "0")
    }
    
    
}


//MARK: ColorUseCase , impl 정의
protocol ColorUseCase{
    func updateColor(with: ColorModel, completion: (ColorModel)->Void)
    func getCurrentColorCount(completion:(ColorModel)-> Void)
}
final class ColorUseCaseImpl : ColorUseCase{
    private let keychainService : KeychainService
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func updateColor(with colorModel: ColorModel, completion: (ColorModel) -> Void) {
        var currentBlueCnt = keychainService.getBlueCount() ?? 0
        var currentRedCnt = keychainService.getRedCount() ?? 0
        switch colorModel.color {
        case .blue:
            if currentBlueCnt*2 < currentRedCnt{
                currentBlueCnt = currentBlueCnt * 2 + 1
            }else{
                currentBlueCnt += 1
            }
        case .red:
            if currentRedCnt*2 < currentBlueCnt{
                currentRedCnt = currentRedCnt * 2 + 1
            }else{
                currentRedCnt += 1
            }
        }
        updateColor(currentBlueCnt, currentRedCnt)
        
        let colorModel = ColorModel(color: colorModel.color, currentBlueColor: currentBlueCnt, currentRedColor: currentRedCnt)
        
        completion(colorModel)
    }
    
    
    func getCurrentColorCount(completion: (ColorModel) -> Void) {
        let currentBlueCnt = keychainService.getBlueCount() ?? 0
        let currentRedCnt = keychainService.getRedCount() ?? 0
        let colorModel = ColorModel(color: .blue, currentBlueColor: currentBlueCnt, currentRedColor: currentRedCnt)
        completion(colorModel)
    }
    
    private func updateColor(_ blueColorCnt: Int, _ redColorCnt: Int){
        keychainService.saveRedCount(redColorCnt)
        keychainService.saveBlueCount(blueColorCnt)
    }
    
    
}
