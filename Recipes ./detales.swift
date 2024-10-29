import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RecipeViewModel
    @State private var showDeleteAlert = false // State variable to control the alert
    var recipe: Recipe // Recipe is your data model

    var body: some View {
        VStack(alignment: .leading) {
            // Recipe Image with Gradient Overlay
            if let image = recipe.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 250)
                }
                .padding(.top)
            }
            
            Text(recipe.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Ingredients Section Title
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top, 10)
            
            // Dynamic Ingredients List
            ForEach(recipe.ingredients) { ingredient in
                HStack(spacing: 10) {
                    Text("\(ingredient.serving)")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding(.leading, 8)
                    
                    Text(ingredient.name)
                        .font(.body)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(ingredient.measurement == "Spoon" ? "🥄 Spoon" : "🥛 Cup")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .frame(height: 29)
                        .background(Color.orange.opacity(0.8))
                        .cornerRadius(4)
                        .padding(.trailing, 8)
                }
                .padding()
                .frame(width: 370, height: 52)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 5)
            }
            
            Spacer()
            
            // Delete Button
            Button(action: {
                showDeleteAlert = true // Show the delete confirmation alert
            }) {
                Text("Delete Recipe")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete Recipe ?"),
                    message: Text("Are you sure you want to delete the recipe?"),
                    primaryButton: .destructive(Text("Yes")) {
                        viewModel.deleteRecipe(recipe)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
        .navigationTitle(Text(recipe.title))
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.orange)
                    Text("Back")
                        .foregroundColor(.orange)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Add logic for editing the recipe
                }) {
                    Text("Edit")
                        .foregroundColor(.orange)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
