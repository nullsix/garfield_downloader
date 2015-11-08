require 'fileutils'
require 'date'
require 'open-uri'

class Garfield
  class Downloader
    attr_accessor :total_images_count,
      :downloaded_images_count,
      :skipped_images_count

    def initialize
      self.total_images_count      = 0
      self.downloaded_images_count = 0
      self.skipped_images_count    = 0

      FileUtils.mkdir_p(images_root)
    end

    def download_all
      current_date = Date.today

      loop do
        self.total_images_count += 1

        current_image_path = image_path(current_date)

        if image_exists?(current_image_path)
          self.skipped_images_count += 1

        else
          self.downloaded_images_count += 1
          current_image_url  = image_url(current_date)
          current_image_data = download_image_data(current_image_url)

          write_image_data(current_image_path, current_image_data)

          sleep(rand())
        end


        current_date -= 1

        print_progress
      end
    rescue OpenURI::HTTPError
      puts "Couldn't open #{current_image_url}..."
    rescue Interrupt
      print "\r"
      print_progress
      print "\n"
    end

  private

    def images_root
      "strips"
    end

    def image_url(date)
      "https://garfield.com/uploads/strips/#{date.to_s}#{image_extension}"
    end

    def image_path(date)
      File.join(images_root, "#{date.to_s}#{image_extension}")
    end

    def image_extension
      ".jpg"
    end

    def download_image_data(image_url)
      open(image_url) do |image|
        image.read
      end
    end

    def write_image_data(image_path, image_data)
      File.open(image_path, 'w') do |f|
        f.write(image_data)
      end
    end

    def image_exists?(image_path)
      File.exist?(image_path)
    end

    def print_progress
      print "Total: #{total_images_count}; Downloaded: #{downloaded_images_count}; Skipped: #{skipped_images_count}\r"
    end
  end
end

Garfield::Downloader.new.download_all

