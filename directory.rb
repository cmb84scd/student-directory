def interactive_menu
  students = []
  loop do
    # print the menu and ask the user what to do
    puts "1. Input  the students"
    puts "2. Show the students"
    puts "9. Exit"
    # read the input and save it into a variable
    selection = gets.chomp
    # do what the user has asked
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, just hit return three times"
  # create an empty array
  students = []
  # get the first name
  name, cohort = gets.chomp, gets.chomp.to_sym
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student to hash to the array
    students << {name: name, cohort: cohort}
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name, cohort = gets.chomp, gets.chomp.to_sym
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  if students.count == 0
    puts "There are no students enrolled"
  else
    students.each do |student|
      puts "#{student[:name]}, (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

interactive_menu
