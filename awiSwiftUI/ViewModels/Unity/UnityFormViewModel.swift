//
//  UnityFormViewModel.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import Foundation

class UnityFormViewModel : UnityDelegate, ObservableObject{
    
    private var model : Unity
    
    @Published var unityName : String{
        didSet{
            if(self.model.unityName != self.unityName){
                self.model.unityName = self.unityName
                if(self.model.unityName != self.unityName){
                    self.unityName = self.model.unityName
                }
            }
        }
    }
    
    init(model:Unity){
        self.model = model
        self.unityName = model.unityName
        self.model.delegate = self
    }
    
    func unityChange(unityName: String) {
        self.unityName = unityName
    }
    
    func unityChange(id: Int) {
    }
}
