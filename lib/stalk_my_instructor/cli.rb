require_relative 'webcam'
require_relative 'scraper'

class StalkMyInstructor::CLI

  def call
    # @session = StalkMyInstructor::Scraper.new
    main_menu
  end

  def main_menu
    display
    get_info
    get_input

  end

  def display
    system "clear"
    puts "Welcome!"
    puts " "
    puts "Choose from the menu below:"
    puts "   ----- ------ -----   "
    puts ""
    puts "1 - Stalk!"
    puts "2 - How to use?"
    puts ""
    bottom_menu
  end

  def get_input
    user_input = ""
      user_input = gets.to_s.chomp.downcase
      user_input
  end

  def bottom_menu
    puts ""
    puts ""
    puts "[menu] --- [exit] --- [legal]"
    puts "(c) 2016"
    puts ""
  end

  def get_info
    status = true
    while status
      input = get_input
    case input
      when "1"
        start_webcam
        

      when "menu"
        main_menu
      when "2"
        puts ""
        how_to_use
        puts ""
      when "exit"
        puts ""
        puts "Stalk you later,"
        puts "Bye!"
        puts ""
        exit
      when "legal"
        system "clear"
        legal_info
        bottom_menu
      else
        puts " "
        puts  "Sorry please try again"
        puts " "
      end
    end
  end

  def how_to_use
    system "clear"
    puts "Select \“Stalk My Instructor\” from the main menu the program will activate your computer’s web camera. At this stage, it may be wise to open up a program where you can view what your web camera sees. Press any key except “Q” to take a picture. Preview will open up the snapshot you just took, and if you like it, you can will need to simply save the picture as snap.pjg, and then press “Q” in the terminal. The program will detect the individual’s identity and will display their information to you in the terminal."
    bottom_menu
    get_info
  end

  def legal_info
    puts "In the United States \“It is legal to photograph or videotape anything and anyone on any public property\” (Krages II, Bert P. \"The Photographer's Right\").  So go out there and have fun without worries!"
  end

  def start_webcam
    webcam
    mock_scan
    profile_match
  end

  def mock_scan
    system "clear"
    puts ""
    puts "type 'q' to quit"
    puts ""
    sleep(1)
    puts "...scanning picture"
    sleep(2)
    puts "using facial recognition intelligence to match profile..."
    sleep(2)
    puts ""
    puts ""
  end

  def profile_match
    #confidence level
    # if confidence < 75
      #Iterate through the instructor hash, and find a 
  end

  def stalk_menu(arg)
    system "clear"
    puts "We found 1 match!"
    # puts "Name: #{@session.fname} #{@session.lname}"
    # puts "Email Address: #{@session.email}"
    # puts "Company: #{@sessions.job_title}"
    puts "Education: "
    puts "Experience: "
    puts " "
    puts "   ----- ------ -----   "
    bottom_menu
  end

end