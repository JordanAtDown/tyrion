# frozen_string_literal: true

# Definition des niveaux de log
module LoggerLevel
  # LoggerLevelDefinitionErreur
  class LoggerLevelDefinitionErreur < StandardError; end

  DEBUG = :debug
  INFO = :info
  WARN = :warn
  ERROR = :error
  FATAL = :fatal

  def self.log_level(log)
    case log
    when "debug"
      LoggerLevel::DEBUG
    when "info"
      LoggerLevel::INFO
    when "warn"
      LoggerLevel::WARN
    when "error"
      LoggerLevel::ERROR
    when "fatal"
      LoggerLevel::FATAL
    else
      raise LoggerLevel::LoggerLevelDefinitionErreur, "Le niveau de log est incorrect"
    end
  end
end
