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
    var recipeIntent : RecipeIntent
    
    init(recipeIntent : RecipeIntent){
        self.recipeIntent = recipeIntent
        self.intent = StepIntent()
        self.intent.addObserverList(viewModel: self.stepListVM)
    }
    var body: some View {
        
            VStack {
                ForEach(stepListVM.steps, id: \.self) { step in
                    NavigationLink(destination : StepForm(intent: self.intent, stepFormVM: StepFormVM(model: step))){
                        Text(step.title)
                    }
                    
                }
                Spacer()
                Button("Publish recipe"){
                    Task{
                        
                    }
                }
                    .padding()
                    .background(Color.salmon)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.bottom)
                    
            }
            .navigationTitle("Steps")
            .navigationBarItems(trailing: NavigationLink(destination: StepForm(intent: self.intent)){
                Image(systemName: "plus")
            })
            
        
        }
}
/*
struct StepList_Previews: PreviewProvider {
    static var previews: some View {
        StepList()
    }
}
*/
