# frozen_string_literal: true

class RSS::Builder
  attr_reader :dsl

  def self.build
    new.tap do |builder|
      yield builder.dsl
    end.to_xml
  end

  def initialize
    @dsl = RSS::Channel.new
  end

  def to_xml
    Ox.dump(wrap_in_document, effort: :tolerant).force_encoding('UTF-8')
  end

  private

  def wrap_in_document
    Ox::Document.new(version: '1.0').tap do |document|
      document << xml_instruct
      document << xsl_instruct
      document << Ox::Element.new('rss').tap do |rss|
        rss['version'] = '2.0'
        rss['xmlns'] = 'http://webfeeds.org/rss/1.0'
        rss['xmlns:webfeeds'] = 'http://webfeeds.org/rss/1.0'
        rss['xmlns:media']    = 'http://search.yahoo.com/mrss/'

        rss << @dsl.to_element
      end
    end
  end

  def xml_instruct
    Ox::Instruct.new(:xml).tap do |instruct|
      instruct[:version] = '1.0'
      instruct[:encoding] = 'UTF-8'
    end
  end

  def xsl_instruct
    Ox::Instruct.new('xsl-stylesheet').tap do |instruct|
      # XXX: Allow this path to be passed in from the view?
      instruct[:href] = asset_path('feed.xsl', skip_pipeline: true)
      instruct[:type] = 'text/xsl'
    end
  end
end
