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
                /*
                Button("Publish steps"){
                    Task{
                        let res = await self.intent.intentToCreateSteps(recipeId: recipe.id!, steps: self.stepListVM.steps)
                        
                        switch(res){
                            
                        case .success(let postedRecipe):
                            
                            //self.$previousPagePresentationMode.wrappedValue.dismiss()
                            self.presentationMode.wrappedValue.dismiss()
                            
                        case .failure(_):
                            print("failure in steplist view")
                        }
                    }
                }
                .padding()
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.bottom)
                 */
                Spacer()
                /*
                Button("Publish recipe"){
                    Task{
                        let res = await self.recipeIntent.intentToCreateRecipe(recipe: self.recipeModel)
                        
                        switch(res){
                            
                        case .success(let postedRecipe):
                            await self.intent.intentToCreateSteps(recipeId: postedRecipe.id!, steps: self.stepListVM.steps)
                            //self.$previousPagePresentationMode.wrappedValue.dismiss()
                            self.presentationMode.wrappedValue.dismiss()
                            
                        case .failure(_):
                            print("failure in steplist view")
                        }
                    }
                }
                .padding()
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.bottom)
                Spacer()
                 */
            }
            /*
            NavigationLink(destination: StepForm(intent: self.intent, stepFormVM: nil,recipe : self.recipe)){
                Text("Testt")
            }
            .background(.green)
             */
            
            
        }
        .padding()
        .navigationTitle("Steps")
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
/*
 struct StepList_Previews: PreviewProvider {
 static var previews: some View {
 StepList()
 }
 }
 */
