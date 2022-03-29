# frozen_string_literal: true

require "logger_level"

RSpec.describe LoggerLevel do
  it "doit définir les différents niveau de log possible" do
    expect(LoggerLevel::DEBUG).to be :debug
    expect(LoggerLevel::INFO).to be :info
    expect(LoggerLevel::WARN).to be :warn
    expect(LoggerLevel::ERROR).to be :error
    expect(LoggerLevel::FATAL).to be :fatal
  end

  it "doit pouvoir retrouver le niveau de log défini" do
    expect(LoggerLevel.log_level("debug")).to be LoggerLevel::DEBUG
    expect(LoggerLevel.log_level("info")).to be LoggerLevel::INFO
    expect(LoggerLevel.log_level("warn")).to be LoggerLevel::WARN
    expect(LoggerLevel.log_level("error")).to be LoggerLevel::ERROR
    expect(LoggerLevel.log_level("fatal")).to be LoggerLevel::FATAL
  end

  it "doit lever une exception si le niveau de log défini est incorrect" do
    expect do
      LoggerLevel.log_level("autre")
    end.to raise_error(LoggerLevel::LoggerLevelDefinitionErreur,
                       "Le niveau de log est incorrect")
  end
end
