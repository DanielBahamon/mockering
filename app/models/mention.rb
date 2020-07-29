class Mention < ApplicationRecord

  attr_reader :mentionable

  include Rails.application.routes.url_helpers


  def self.all(letters)
    return Mention.none unless letters.present?
    mockers = Mocker.limit(5).where('slug like ?', "#{letters}%").compact
    mockers.map do |mocker|
      { name: mocker.slug, 
        image:  if mocker.provider != "facebook" && !mocker.photo?
                  if mocker.image
                    ActionController::Base.helpers.image_tag(mocker.image)
                  else
                    gravatar_id = Digest::MD5::hexdigest(mocker.email).downcase
                     ActionController::Base.helpers.image_tag("https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=150")
                  end
                elsif mocker.provider == "facebook" && !mocker.photo?
                   ActionController::Base.helpers.image_tag("https://graph.facebook.com/#{mocker.uid}/picture?type=large")
                else
                   ActionController::Base.helpers.image_tag(mocker.photo.url(:medium))
                end
      }
    end
  end

  def self.create_from_text(mock)
    potential_matches = mock.description.scan(/@\w+/i)
    potential_matches.uniq.map do |match|
      mention = Mention.create_from_match(match)
      next unless mention
      mock.update_attributes!(description: mention.markdown_string(mock.description))
      # You could fire an email to the user here with ActionMailer
      mention
    end.compact
  end

  def self.create_from_match(match)
    mocker = Mocker.find_by(slug: match.delete('@'))
    MockerMention.new(mocker) if mocker.present?
  end

  def initialize(mentionable)
    @mentionable = mentionable
  end

  class MockerMention < Mention
    def markdown_string(text)
      regex =  %r{
      \b
        (
          (?: [a/z][\w-]+:
            (?: /{1,3} | [a-z0-9%] ) |
            www\d{0,3}[.] | 
            [a-z0-9.\-]+[.][a-z]{2,4}/
          )
          (?:
           [ˆ\s()<>]+ | \(([ˆ\s()<>]+|(\([ˆ\s()<>]+\)))*\)
          )+
          (?:
            \(([ˆ\s()<>]+|(\([ˆ\s()<>]+\)))*\) |
            [ˆ\s‘!()\[\]{};:'".,<>?«»""'']
          )
        )
      }ix

      # url_regexp = %r{
      #   (?:(?:https?|ftp|file):\/\/|www\.|ftp\.)
      #   (?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|
      #        [-A-Z0-9+&@#\/%=~_|$?!:,.])*
      #   (?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|
      #         [A-Z0-9+&@#\/%=~_|$])
      # }ix
      # text.gsub(url_regexp, "<a href='#{mocker_url(mentionable, host: host)}' target='_blank'> @#{mentionable.slug}</a>").html_safe
      # text.gsub(/@#{mentionable.slug}/i, "@#{mentionable.slug} #{mocker_url(mentionable, host: host)}")

      host = Rails.env.development? ? 'localhost:3000' : 'mockering.herokuapp.com' # add your app's host here!
      text.gsub(/@#{mentionable.slug}/i, "<a href='#{mocker_url(mentionable, host: host)}' target='_blank'>@#{mentionable.slug}</a>")
      # text.gsub(regex) do |url|
      #   "<a href='#{mocker_url(mentionable, host: host)}' target='_blank'> @#{mentionable.slug}</a>"
      # end

    end
  end

end