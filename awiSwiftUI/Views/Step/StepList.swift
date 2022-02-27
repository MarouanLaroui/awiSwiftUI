//
//  StepList.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import SwiftUI

struct StepList: View {
    
    @ObservedObject var stepListVM : StepListVM = StepListVM(steps: [])
    var intent : StepIntent
    
    init(){
        self.intent = StepIntent()
        self.intent.addObserverList(viewModel: self.stepListVM)
    }
    var body: some View {
            List {
                ForEach(stepListVM.steps) { step in
                    Text(step.title)
                }
            }
            .navigationTitle("Steps")
            .navigationBarItems(trailing: NavigationLink(destination: StepForm(intent: self.intent)){
                Image(systemName: "plus")
            })
            
            Spacer()
        }
}

struct StepList_Previews: PreviewProvider {
    static var previews: some View {
        StepList()
    }
}
