# frozen_string_literal: true

require "logging"

require "directory"
require "logger_level"

# Configuration de demmarrage
class StartupConfigurator
  PATTERN = Logging.layouts.pattern(
    :pattern => "[%d] %-5l %c: %m\n",
    :date_pattern => "%Y-%m-%d %H:%M:%S"
  )

  def self.builder(date_execution, commande, app)
    new(date_execution, commande, app)
  end

  def initialize(date_execution, commande, app)
    @date_execution = date_execution
    @commande = commande
    @app = app
  end

  def set_log_level(level)
    Logging.logger.root.level = LoggerLevel.log_level(level)
    self
  end

  def set_log_file(path_log)
    dossier = Directory.cree_le(path_log)
    if dossier != ""
      @file_appender = Logging.appenders.file(
        "#{path_log}/#{@app.downcase}-#{@commande}_#{@date_execution.strftime("%Y_%m_%d-%H_%M_%S")}.log",
        :layout => PATTERN
      )
    end
    self
  end

  def startup
    stdout_appender = Logging.appenders.stdout("stdout", :layout => PATTERN)
    Logging.logger.root.add_appenders(stdout_appender)
  end
end
