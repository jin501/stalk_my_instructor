require './lib/scraper'
require './lib/stalker'

class StalkMyInstructor::CLI

  def call
    @session = StalkMyInstructor::StalkMyInstructor.new(scraper)
    main_menu
  end

  def main_menu
    display
    get_info
  end


  def display
    system "clear"
    puts "Welcome!"
    puts " "
    puts "Choose from the menu below:"
    puts "   ----- ------ -----   "
  end

  def get_input
    user_input = ""
      puts "Stalk! - 1"
      puts "Exit - 2"
      user_input = gets.to_s.chomp
      user_input
  end

  def get_info
    status = true
    while status
      input = get_input
    case input
      when "1"
        start_webcam
      when "2"
        puts " "
        puts "Thank you! See you soon!"
        puts " "
        status = false
        exit
      else
        puts " "
        puts  "Sorry please try again"
        puts " "
      end
    end
  end

def start_webcam

  @session.get_data(@session.camera_start)

  puts "Name: #{@session.fname} #{@session.lname}"
  puts "Email Address: #{@session.email}"
  puts "Company: #{@sessions.job_title}"
  puts "Education: "
  puts "Experience: "
  puts " "
  puts "   ----- ------ -----   "
  puts "Press 1 to visit Linkedin"
  puts "Press any other key to go back to main menu"

end

  

end