# frozen_string_literal: true

require "fileutils"

# Startup
module Startup
  APP_NOM = "Tyrion"
  RESTORE_CMD = "restore"

  # Configuration
  class Configuration
    attr_reader :apply, :log_level
    
    def initialize(apply, log_level, dossier_log, nom_cmd, date_execution)
      @apply = apply
      @log_level = log_level
      @dossier_log = dossier_log
      @nom_cmd = nom_cmd
      @date_execution = date_execution
    end

    def log_file
      @dossier_log != ""
    end

    def log
      "#{@dossier_log}/#{APP_NOM.downcase}-#{RESTORE_CMD}_#{@date_execution.strftime("%Y_%m_%d-%H_%M_%S")}.log"
    end
  end

  def self.cree_le(dossier_log)
    if dossier_log != ""
      if !Dir.exist?(dossier_log)
        FileUtils.mkdir_p(dossier_log)
      end
    end
    dossier_log
  end

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

# Definition des niveaux de log
module LoggerLevel
  # LoggerLevelDefinitionErreur
  class LoggerLevelDefinitionErreur < StandardError; end
  DEBUG = :debug
  INFO = :info
  WARN = :warn
  ERROR = :error
  FATAL = :fatal
end
