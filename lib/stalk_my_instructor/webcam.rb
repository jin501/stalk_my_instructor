require 'av_capture'
require 'io/console'
require 'Cloudinary'
require 'carrierwave'
require 'Nokogiri'
require 'pry'

class OurWebcam

  def webcam
    session = AVCapture::Session.new
    dev = AVCapture.devices.find(&:video?)
    session.run_with(dev) do |connection|
      loop do
        case $stdin.getch
        when 'q' then break # quit when you hit 'q'
        else
          IO.popen("open -g -f -a /Applications/Preview.app", 'w') do |f|
            f.write connection.capture
          end
        end
      end
    end
  end

  def upload_image
    image = Cloudinary::Uploader.unsigned_upload("stalkvictim.jpg", "efzzw746", :cloud_name => "ns5001")
    image["url"]
  end

  def make_url
    img_url = upload_image
    match_url = "http://api.skybiometry.com/fc/faces/recognize.json?api_key=895b96b54e72427a9696ce313ddeec67&api_secret=165a42462ccf45968560edffef37c83c&urls=INSERTHERE&uids="
    match_url.gsub! 'INSERTHERE', img_url
    uids = ["alex@flatiron", "ruchi@flatiron", "antoin@flatiron"]
    uids.map do |tag|
      match_url + tag
    end
  end

  def recognize_face
    links = [make_url[0], make_url[1], make_url[2]]
    confidence = {}
    c = 1
    links.each do |link|
      hash = Nokogiri::HTML(open(link))
      confidence["#{c}".to_sym] = hash.text.split("confidence")[1][2..4].to_i
        c+=1
    end
    profile_url = confidence.key(confidence.values.max)
  end

  def get_url
    if recognize_face == :"3"
      url = "https://www.linkedin.com/in/antoincampbell"
    elsif recognize_face == :"2"
      url = "https://www.linkedin.com/in/ruchiramani"
    elsif recognize_face == :"1"
      url = "https://www.linkedin.com/in/alexander-griffith-6ab4a616"
    end
  end

end

# puts OurWebcam.new.recognize_face


