# frozen_string_literal: true

require "observer"
require "fileutils"

require "notification/application_notification"
require "exif/mini_exiftool_manipulateur"

# Définit l'étape d'application
class ApplicationEtape
  include Observable
  
  attr_reader :exif_manipulateur

  def initialize(exif_manipulateur = nil)
    @exif_manipulateur = exif_manipulateur
  end

  def parcours(fichiers)
    changed
    fichiers.each_pair do |key, value|
      notify_observers(Time.now, ApplicationNotification.new(fichier))
      if File.file?(key)
        begin
          exif_manipulateur.set_datetimeoriginal(key, value.date)
          File.rename(key, value.path_nouveau_nom)
          FileUtils.mkdir_p(File.dirname(value.path_destination))
          FileUtils.move(value.path_nouveau_nom, value.path_destination)
          notify_observers(Time.now, ApplicationNotification.new(fichier))
        rescue MiniExifToolManipulateur::ExifManipulateurErreur => e
          notify_observers(Time.now, ApplicationNotification.new(fichier))
        rescue SystemCallError => e
          notify_observers(Time.now, ApplicationNotification.new(fichier))
        end
      else
        notify_observers(Time.now, ApplicationNotification.new(fichier))
      end
    end
  end
end
