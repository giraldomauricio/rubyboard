require 'logger'

class AppLogger

  @@logger = Logger.new(ENV['LOG_LOCATION'] + '/' + Time.now.strftime('%Y%m%d') + '.log')

  def self.info(message, clazz='N/A', method='N/A')
    AppLogger.get_log_time_format
    @@logger.info(AppLogger.format_output(clazz, method, message))
  end

  def self.debug(message, clazz='N/A', method='N/A')
    AppLogger.get_log_time_format
    @@logger.debug(AppLogger.format_output(clazz, method, message))
  end

  def self.error(message, clazz='N/A', method='N/A')
    AppLogger.get_log_time_format
    @@logger.error(AppLogger.format_output(clazz, method, message))
  end

  def self.warning(message, clazz='N/A', method='N/A')
    AppLogger.get_log_time_format
    @@logger.warn(AppLogger.format_output(clazz, method, message))
  end

  def self.get_log_time_format
    @@logger.formatter = proc do |severity, datetime, program_name, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      "[#{date_format}] - (#{program_name}) #{'[%5s]'% severity.upcase} - #{msg.inspect}\n"
    end
  end

  def self.format_output(clazz, method, message)
    " - class=#{clazz} - method=#{method} - message=" + message
  end

end
