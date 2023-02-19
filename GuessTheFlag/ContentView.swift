import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var resetingGame = false
    @State private var scoreTitle = ""
    @State private var scoreTitleFinal = ""
    @State private var scoreUser = 0
    @State private var numberOfPlays = 0
    
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(scoreUser)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreUser)")
        }
        .alert(scoreTitleFinal, isPresented: $resetingGame) {
            Button("Reset", action: resetGame)
        }
    }
    
    func flagTapped(_ number: Int) {
        numberOfPlays += 1
        
        guard numberOfPlays < 4 else {
            scoreTitleFinal = "The point is final. Continue to restart the game"
            resetingGame = true
            return
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreUser += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            scoreUser -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        scoreUser = 0
        numberOfPlays = 0
        showingScore = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
