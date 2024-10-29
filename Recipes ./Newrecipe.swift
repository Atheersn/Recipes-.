import SwiftUI

struct NewRecipeView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showPopup = false
    @State private var ingredientName: String = ""
    @State private var measurement: String = "Spoon"
    @State private var serving: Int = 1
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: RecipeViewModel
    let measurements = ["Spoon", "Cup"]

    var body: some View {
        ZStack {
            NavigationStack {
                VStack(spacing: 20) {
                    // Upload Photo Button
                    Button(action: { showImagePicker = true }) {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 430, height: 181)
                                .overlay(
                                    VStack {
                                        if let image = selectedImage {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 430, height: 181)
                                                .clipped()
                                        } else {
                                            VStack {
                                                Image(systemName: "photo.badge.plus")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 80, height: 60)
                                                    .foregroundColor(.orange)
                                                Text("Upload Photo")
                                                    .foregroundColor(.black)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }
                                )
                            VStack {
                                Rectangle()
                                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .foregroundColor(.orange)
                                    .frame(height: 2)
                                    .offset(y: -85)
                                Rectangle()
                                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .foregroundColor(.orange)
                                    .frame(height: 2)
                                    .offset(y: 85)
                            }
                            
                        }
                        
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }

                    // Title and Description Fields
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Title")
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        TextField("Enter title", text: $title)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(height: 47)

                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        TextField("Enter description", text: $description)
                            .padding()
                            .frame(height: 130, alignment: .topLeading)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)

                        // Ingredients Section
                        HStack {
                            Text("Add Ingredients")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: { showPopup = true }) {
                                Image(systemName: "plus")
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                        }
                        ForEach(viewModel.ingredients) { ingredient in
                            HStack {
                                Text("\(ingredient.serving)")
                                    .foregroundColor(.orange)
                                Text(ingredient.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                Spacer()
                                Text(ingredient.measurement == "Spoon" ? "🥄 Spoon" : "🥛 Cup")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 2)
                                    .frame(width: 95, height: 29)
                                    .background(Color.orange)
                                    .cornerRadius(4)
                            }
                            .padding()
                            .frame(width: 370, height: 52)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .padding()
                .navigationTitle("New Recipe")
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.orange)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            viewModel.addRecipe(title: title, description: description, image: selectedImage)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.orange)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            if showPopup {
                ZStack {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Text("Ingredient Name")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                            .padding(.top, 50)
                        
                        TextField("Ingredient Name", text: $ingredientName)
                            .padding()
                            .frame(height: 39)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)

                        Text("Measurement")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                            .padding(.top, 21)

                        HStack(spacing: 10) {
                            ForEach(measurements, id: \.self) { measure in
                                Button(action: {
                                    measurement = measure
                                }) {
                                    Text(measure == "Spoon" ? "🥄 Spoon" : "🥛 Cup")
                                        .frame(width: 104, height: 31)
                                        .background(measurement == measure ? Color.orange : Color(UIColor.systemGray6))
                                        .foregroundColor(measurement == measure ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.leading)

                        Text("Serving")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 241, height: 36)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .cornerRadius(4)
                            HStack(spacing: 2) {
                                Button(action: {
                                    if serving > 1 { serving -= 1 }
                                }) {
                                    Image(systemName: "minus.square")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.orange)
                                }
                                
                                Text("\(serving)")
                                    .font(.system(size: 20))
                                    .padding(.horizontal, 4)
                                
                                Button(action: {
                                    serving += 1
                                }) {
                                    Image(systemName: "plus.square")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.orange)
                                }
                                
                                Text(measurement == "Spoon" ? "🥄 Spoon" : "🥛 Cup")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 2)
                                    .frame(width: 155, height: 36)
                                    .background(Color.orange)
                                    .cornerRadius(4)
                            }
                        }
                        .padding(.leading)
                        .padding(.bottom, 47)

                        HStack(spacing: 5) {
                            Button("Cancel") { showPopup = false }
                                .frame(width: 130, height: 36)
                                .background(Color(UIColor.systemGray5))
                                .foregroundColor(.orange)
                                .cornerRadius(4)
                            
                            Spacer()
                            
                            Button("Add") {
                                if !ingredientName.isEmpty {
                                    viewModel.addIngredient(name: ingredientName, measurement: measurement, serving: serving)
                                }
                                ingredientName = ""
                                measurement = "Spoon"
                                serving = 1
                                showPopup = false
                            }
                            .frame(width: 134, height: 36)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                    .frame(width: 306, height: 382)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 20)
                    .padding()
                }
                .transition(.scale)
                .animation(.easeInOut, value: showPopup)
            }
        }
    }
}

// ImagePicker for selecting an image from the photo library
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(viewModel: RecipeViewModel())
    }
}
