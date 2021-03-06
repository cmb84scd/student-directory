require 'csv'

@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input  the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "What do you want to call the file?"
    @save_file = STDIN.gets.chomp
    save_students
  when "4"
    puts "What file do you want to open?"
    @load_file = STDIN.gets.chomp
    load_students
  when "5"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student to hash to the array
    add_students(name, :november)
    puts "Now we have #{@students.count} #{plural}"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def plural
  @students.count == 1 ? "student" : "students"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  if @students.count == 0
    puts "There are no students enrolled"
  else
    @students.each do |student|
      puts "#{student[:name]}, (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great #{plural}"
end

def save_students
  if @students.count == 0
    puts "nothing to save"
  else
    CSV.open(@save_file, "w") do |file|
      @students.each do |student|
        file << [student[:name], student[:cohort]]
      end
    end
  puts "Student data saved to #{@save_file}"
  end
end

def load_students(filename = @load_file)
  CSV.foreach(filename) do |line|
    name, cohort = line[0], line[1]
    add_students(name, cohort)
  end
  if @students.count == 0
    puts "Nothing in file"
  else
    puts "Student data loaded"
  end
end

def try_load_students
  filename = ARGV.first # first agrument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
