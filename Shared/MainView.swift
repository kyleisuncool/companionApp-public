//
//  MainView.swift
//  companionApp
//
//  Created by Kyle Joseph on 3/18/23.
//

import SwiftUI
import OpenAISwift

struct MainView: View {
    
    @State private var chatText: String = ""
    let openAI = OpenAISwift(authToken: "<OPENAI_AUTH_TOKEN>")
    @EnvironmentObject private var model: Model
    
    @State private var isSearching: Bool = false
    
    private var isFormValid: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    
    private func performSearch() {
        openAI.sendCompletion(with: chatText, maxTokens: 750) { result in
            switch result {
                case .success(let success):
                    let answer = success.choices.first?.text.trimmingCharacters(in:
                            .whitespacesAndNewlines) ?? ""
                
                let query = Query(question: chatText, answer: answer)
                
                DispatchQueue.main.async {
                    model.queries.append(query)
                }
                
                do {
                    try model.saveQuery(query)
                } catch {
                    print(error.localizedDescription)
                }
                
                chatText = ""
                isSearching = false
                
                case .failure(let failure):
                    isSearching = false
                    print(failure)
            }
        }
    }
    
    var body: some View {
        VStack {
            
            ScrollView{
                
                ScrollViewReader{ proxy in
                    ForEach(model.queries){ query in
                        VStack(alignment: .leading) {
                            Text(query.question)
                                .fontWeight(.bold)
                            Text(query.answer)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom], 10)
                            .id(query.id)
                            .listRowSeparator(.hidden)
                    }.listStyle(.inset)
                        .onChange(of: model.queries) { query in
                            if !model.queries.isEmpty {
                                let lastQuery = model.queries[model.queries.endIndex - 1]
                                withAnimation {
                                    proxy.scrollTo(lastQuery.id)
                                }
                            }
                        }
                }
                
            }.padding()
            
            Spacer()
            
            HStack{
                TextField("Ask a question", text: $chatText)
                    .textFieldStyle(.automatic)
                Button{
                    // action
                    isSearching = true
                    performSearch()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .rotationEffect(Angle(degrees: 45))
                }.buttonStyle(.borderless)
                    .tint(.blue)
                    .disabled(!isFormValid)
                    
            }
        }.padding()
            .onChange(of: model.query) { query in
                model.queries.append(query)
            }
            .overlay(alignment: .center) {
                if isSearching {
                    ProgressView("Searching...")
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model())
    }
}
