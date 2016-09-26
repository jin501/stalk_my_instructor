require 'av_capture'
require 'io/console'

class Webcam

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

  def upload_image
    image = Cloudinary::Uploader.unsigned_upload("snap.jpg", "efzzw746", :cloud_name => "ns5001")
    image["url"]
  end

  def make_url
    img_url = upload_image
    match_url = "http://api.skybiometry.com/fc/faces/recognize.json?api_key=895b96b54e72427a9696ce313ddeec67&api_secret=165a42462ccf45968560edffef37c83c&urls=INSERTHERE&uids="
    match_url.gsub! 'INSERTHERE', img_url
    uids = ["alex@flatiron", "ruchi@flatiron", "antoin@flatiron"]
    uids.map do |x|
      match_url + x
    end
  end

  def recognize_face
    url = [make_url[0], make_url[1], make_url[2]]

    urls.each do |url|
      x = Nokogiri::HTML(open(url))
      binding.pry
      # x.search('con')

  end

end


