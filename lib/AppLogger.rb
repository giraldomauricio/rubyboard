require 'logger'

class AppLogger

  @@logger = Logger.new(ENV['LOG_LOCATION'] + '/' + Time.now.strftime('%Y%m%d') + '.log')

  def self.info(message, clazz='N/A', method='N/A')
    @@logger.level = Logger::DEBUG
    @@logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      "[#{date_format}] - (#{progname}) #{'[%5s]'% severity.upcase} - #{msg.inspect}\n"
    end
    @@logger.info(" - class=#{clazz} - method=#{method} - message=" + message)
  end

  def self.debug(message, clazz='N/A', method='N/A')
    @@logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      "[#{date_format}] - (#{progname}) #{'[%5s]'% severity.upcase} - #{msg.inspect}\n"
    end
    @@logger.debug(" - class=#{clazz} - method=#{method} - message=" + message)
  end

  def self.error(message, clazz='N/A', method='N/A')
    @@logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      "[#{date_format}] - (#{progname}) #{'[%5s]'% severity.upcase} - #{msg.inspect}\n"
    end
    @@logger.error(" - class=#{clazz} - method=#{method} - message=" + message)
  end

  def self.warning(message, clazz='N/A', method='N/A')
    @@logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      "[#{date_format}] - (#{progname}) #{'[%5s]'% severity.upcase} - #{msg.inspect}\n"
    end
    @@logger.warn(" - class=#{clazz} - method=#{method} - message=" + message)
  end

end
