# frozen_string_literal: true

require "startup"

RSpec.describe Startup do
  it "doit generer le fichier de log à l'emplacement voulu avec le nom de la fonction, nom de l'application et la date d'exécution" do
    configuration = Startup::Configuration.new(true, LoggerLevel::DEBUG, "#{FileHelpers::TMP}test01/log", Startup::RESTORE_CMD, DateTime.new(2022, 3, 18, 7, 45, 34))
    expect(configuration.log).to eql "/tmp/test01/log/tyrion-restore_2022_03_18-07_45_34.log"
  end

  it "doit définir si le log à été défini" do
    configuration = Startup::Configuration.new(true, LoggerLevel::DEBUG, "#{FileHelpers::TMP}test01/log", Startup::RESTORE_CMD, DateTime.new(2022, 3, 18, 7, 45, 34))
    expect(configuration.log_file).to be_truthy

    configuration_sans_log = Startup::Configuration.new(true, LoggerLevel::DEBUG, "", Startup::RESTORE_CMD, DateTime.new(2022, 3, 18, 7, 45, 34))
    expect(configuration_sans_log.log_file).to be_falsy
  end

  it "doit creer le dossier de l'emplacement de log" do
    dossier_log = Startup.cree_le("#{FileHelpers::TMP}test01/log")

    expect(Dir.exist?(dossier_log[0])).to be_truthy
  end

  it "ne doit pas creer le dossier de l'emplacement de log si aucun n'a été défini" do
    expect(Startup.cree_le("")).to eql ""
  end

  it "doit définir les différents niveau de log possible" do
    expect(LoggerLevel::DEBUG).to be :debug
    expect(LoggerLevel::INFO).to be :info
    expect(LoggerLevel::WARN).to be :warn
    expect(LoggerLevel::ERROR).to be :error
    expect(LoggerLevel::FATAL).to be :fatal
  end

  it "doit pouvoir retrouver le niveau de log défini" do
    expect(Startup.log_level("debug")).to be LoggerLevel::DEBUG
    expect(Startup.log_level("info")).to be LoggerLevel::INFO
    expect(Startup.log_level("warn")).to be LoggerLevel::WARN
    expect(Startup.log_level("error")).to be LoggerLevel::ERROR
    expect(Startup.log_level("fatal")).to be LoggerLevel::FATAL
  end

  it "doit lever une exception si le niveau de log défini est incorrect" do
    expect { Startup.log_level("autre") }.to raise_error(LoggerLevel::LoggerLevelDefinitionErreur, "Le niveau de log est incorrect")
  end
end
