//
//  StepList.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import SwiftUI

struct StepList: View {
    
    @Binding var previousPagePresentationMode: PresentationMode
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var stepListVM : StepListVM = StepListVM(steps: [])
    @ObservedObject var recipeModel : Recipe
    var intent : StepIntent
    var recipeIntent : RecipeIntent
    
    init(recipeIntent : RecipeIntent, recipeModel : Recipe, intent : StepIntent = StepIntent(), previousPagePresentationMode: Binding<PresentationMode>){
        self.recipeModel = recipeModel
        self.intent = intent
        self.recipeIntent = recipeIntent
        self._previousPagePresentationMode = previousPagePresentationMode
        self.intent.addObserverList(viewModel: self.stepListVM)
    }
    
    var body: some View {
        
        VStack(alignment : .leading) {
            ForEach(stepListVM.steps, id: \.self) { step in
                NavigationLink(destination : StepForm(intent: self.intent, stepFormVM: StepFormVM(model: step))){
                    Text(step.title)
                }
                Divider()
                
            }
            Spacer()
            HStack{
                Spacer()
                Button("Publish recipe"){
                    Task{
                        let res = await self.recipeIntent.intentToCreateRecipe(recipe: self.recipeModel)
                        
                        switch(res){
                            
                        case .success(let postedRecipe):
                            await self.intent.intentToCreateSteps(recipeId: postedRecipe.id!, steps: self.stepListVM.steps)
                            self.$previousPagePresentationMode.wrappedValue.dismiss()
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
            }
            NavigationLink(destination: StepForm(intent: self.intent, stepFormVM: nil)){
                Text("Testt")
            }
            .background(.green)
            
            
        }
        .padding()
        .navigationTitle("Steps")
        .navigationBarItems(trailing: NavigationLink(destination: StepForm(intent: self.intent, stepFormVM: nil)){
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
