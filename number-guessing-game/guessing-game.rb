def playAgain
    puts "Would you like to play again? (Y/N)"
    case gets.chomp.to_s.downcase
    when "y"
        playGame
    else
        exit 0
    end
end

def playGame
    start_time = Time.now
    puts "Welcome to the Number Guessing Game!"
    puts "Select a diificulty level:"
    puts "1. Easy \t (10 chances)"
    puts "2. Medium \t (5 chances)"
    puts "3. Hard \t (3 chances)"

    case gets.chomp.to_i
    when 1
        chances = 10
        difficulty = "Easy"
    when 2
        chances = 5
        difficulty = "Medium"
    when 3 
        chances = 3
        difficulty = "Hard"
    else
        puts "Invalid difficulty!"
        exit 1
    end

    puts "Great, you have selected the #{difficulty} diffculty level!"
    puts "You have #{chances} chances to guess the correct number"

    number = Random.rand(1..100)
    puts "I'm thinking of a number between 1 and 100."

    attempts = 0
    while(attempts < chances)
        puts "Enter your choice:"
        choice = gets.chomp.to_i
        
        puts "Incorrect! The number is less than #{choice}." if number < choice
        puts "Incorrect! The number is greater than #{choice}." if choice < number
        
        if choice == number 
            puts "Congratulations! You guessed the correct number in #{attempts} attempts."
            puts "Time: #{Time.now - start_time}"
            playAgain
        end

        attempts += 1
    end
    puts "You ran out of guesses!"
    playAgain
end

playGame