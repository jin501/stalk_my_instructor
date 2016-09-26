require 'open-uri'
require 'nokogiri'
require 'pry'
require 'net/http'
require 'mechanize'

class Scraper

  def new_session(url)
    agent = Mechanize.new
    page = agent.get('https://www.linkedin.com/uas/login')

    # page.forms[0].action #https://www.linkedin.com/uas/login-submit
    signin = page.form('login')
    signin.session_key = '.com'
    signin.session_password = ''
    page = agent.submit(signin, signin.buttons[1])

    get_page = agent.get(url)

    profile_hash = {
    name: get_page.search('span.full-name').text,
    title: get_page.search('p.title').text,
    home_location: get_page.search('span.locality')[0].text,
    work_location: get_page.search('span.locality')[1].text,
    industry: get_page.search('dd.industry').text,
    connections: get_page.search('div.member-connections').text,
    :skills => [], #how about only listing endorsed skills?
    :interests => [], #what they support
    :experiences => {
      :job_title => [],
      :company => [],
      :duration => [],
      :job_description => [],
      :company_logos => []
      },
    :education => {
      :school => [],
      :date => [],
      :major => [],

      },
    :organizations_supported => []
    }

  ###profile_hash[:skills]
  #iteration over :skills to fill profile_hash[:skills] array
        get_page.search('a.endorse-item-name-text').each do |skills|
          profile_hash[:skills] << skills.text
        end
  ###profile_hash[:interests]
  #iteration over :interests to fill profile_hash[:interests] array
        get_page.search('div.interests li').each do |interests|
          profile_hash[:interests] << interests.text
        end

  ###profile_hash[:experiences]
  #master_experiences_hash blob to compare to :job_descriptions
      master_exp_hash = {}
      n = profile_hash[:experiences][:job_title].count * 2
      i = 0
      c = 1
      until i == n
        master_exp_hash["experience#{c}".to_sym] = get_page.search('div[id^="experience-"]')[i].children.text
        i+=2
        c+=1
      end
  #iteration over :experiences to fill profile_hash[:experiences][:job_title] array
        get_page.search('div#background-experience h4').each do |job|
          profile_hash[:experiences][:job_title] << job.text
        end
  #fill profile_hash[:experiences][:company] array
        get_page.search('div#background-experience h5').each do |company|
          if company.text == ""
          else
            profile_hash[:experiences][:company] << company.text
          end
        end
  #iteration over :experiences to fill profile_hash[:experiences][:duration] array
        get_page.search('span.experience-date-locale').each do |duration|
          profile_hash[:experiences][:duration] << duration.text 
          #.split() to separate duration from location in cli
        end
   #iteration over :experiences to fill profile_hash[:experiences][:job_description] array
        get_page.search('div#background-experience').each do |desc|
          
          profile_hash[:experiences][:job_description] << desc.text
        end

  #iteration over :experiences to fill profile_hash[:experiences][:company_logos] array
        # i = 0
        # until i == profile_hash[:experiences][:company] do
        #   url = get_page.search('img.lazy-load')[i].attributes['data-li-src'].value
        #   profile_hash[:experiences][:company_logos] << url
        #   i+=1
        #  end


  ##profile_hash[:education]
  #iteration over :experiences to fill profile_hash[:education][:school] array
        get_page.search('div#background-education h4').each do |school|
          profile_hash[:education][:school] << school.text
        end
  #iteration over :experiences to fill profile_hash[:education][:date] array
        get_page.search('div#background-education span.education-date').each do |date|
          profile_hash[:education][:date] << date.text
        end
  #iteration over :experiences to fill profile_hash[:education][:major] array
        # i = 0
        get_page.search('div#background-education h5').each do |major|
          if major.text == ""
          else
            profile_hash[:education][:major] << major.text
          end
        end

  ##profiles_hash[:organizations_supported]
  #iteration over :organizations_supported to fill profile_hash[:organizations_supported] array
        get_page.search('div#background-volunteering div.non-profits li').each do |org|
          profile_hash[:organizations_supported] << org.text
        end

    binding.pry
    end



    def profile_box
      master_exp_hash = {}
      i = 0
      c = 1
      until
        get_page.search('div[id^="experience-"]')[i].children.text do
        i+=2
        master_exp_hash["experience#{c}".to_sym] = blob.text
        c+=1

        binding.pry
      end
    end

end


url = "https://www.linkedin.com/in/ruchiramani"

Scraper.new.new_session(url)


  
