//
//  StepList.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import SwiftUI

struct StepList: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var stepListVM : StepListVM = StepListVM(steps: [])
    @ObservedObject var recipe : Recipe
    var intent : StepIntent
    //var recipeIntent : RecipeIntent
    
    init(
        //recipeIntent : RecipeIntent,
        recipe : Recipe,
        intent : StepIntent = StepIntent()){
        //self.recipeModel = recipeModel
        self.recipe = recipe
        self.intent = intent
        //self.recipeIntent = recipeIntent
        self.intent.addObserverList(viewModel: self.stepListVM)
    }
    
    var body: some View {
        
        VStack(alignment : .leading) {
            ForEach(stepListVM.steps, id: \.self) { step in
                NavigationLink(destination : StepForm(intent: self.intent, stepFormVM: StepFormVM(model: step), recipe : self.recipe)){
                    Text(step.title)
                }
                Divider()
                
            }
            Spacer()
            HStack{
                Spacer()
                Spacer()
                
            }
            
        }
        .padding()
        .navigationTitle("Etapes")
        .navigationBarItems(trailing: NavigationLink(destination: StepForm(intent: self.intent, stepFormVM: nil,recipe : self.recipe)){
            Image(systemName: "plus")
        })
        
        .task{
            print("before getStepRecipeDet in view")
            let result = await StepDAO.getStepOfRecipeDetailled(recipeId: self.recipe.id!)
            
            switch(result){
            case .success(let steps):
                self.stepListVM.steps = steps
            case .failure(let error):
                print("erreur recipeDetailled")
                print(error.localizedDescription)
            }
        }
        
        
    }
}
