require "active_record"
require "active_record/version"
require "action_view"

require "digest/sha1"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsTaggableOn
  @@delimiter = ','
  @@force_lowercase = false
  @@force_parameterize = false
  @@strict_case_match = false
  @@remove_unused_tags = false

  class << self
    attr_accessor :delimiter

    attr_accessor :force_lowercase

    attr_accessor :force_parameterize

    attr_accessor :strict_case_match

    attr_accessor :remove_unused_tags

    def glue
      delimiter = @@delimiter.kind_of?(Array) ? @@delimiter[0] : @@delimiter
      delimiter.ends_with?(" ") ? delimiter : "#{delimiter} "
    end

    def setup
      yield self
    end
  end

end


require "acts_as_taggable_on/utils"

require "acts_as_taggable_on/taggable"
require "acts_as_taggable_on/acts_as_taggable_on/compatibility"
require "acts_as_taggable_on/acts_as_taggable_on/core"
require "acts_as_taggable_on/acts_as_taggable_on/collection"
require "acts_as_taggable_on/acts_as_taggable_on/cache"
require "acts_as_taggable_on/acts_as_taggable_on/ownership"
require "acts_as_taggable_on/acts_as_taggable_on/related"
require "acts_as_taggable_on/acts_as_taggable_on/dirty"

require "acts_as_taggable_on/tagger"
require "acts_as_taggable_on/tag"
require "acts_as_taggable_on/tag_list"
require "acts_as_taggable_on/tags_helper"
require "acts_as_taggable_on/tagging"

$LOAD_PATH.shift


if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend ActsAsTaggableOn::Compatibility
  ActiveRecord::Base.extend ActsAsTaggableOn::Taggable
  ActiveRecord::Base.send :include, ActsAsTaggableOn::Tagger
end

if defined?(ActionView::Base)
  ActionView::Base.send :include, ActsAsTaggableOn::TagsHelper
end

