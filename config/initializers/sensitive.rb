require 'noaa'

yml_file = File.join(Rails.root, 'config', 'sensitive.yml')

begin
  options = YAML::load(File.read(yml_file))
  NOAA.configure(options.delete("noaa")["token"])
  API_KEYS = options
rescue Exception => ex
  Rails.logger.error "Error parsing sensitive options from yaml file #{yml_file}: #{ex.inspect}"
end

