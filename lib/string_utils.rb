# -*- coding: utf-8 -*-
if RUBY_VERSION < '1.9'
  $KCODE = "UTF8" if $KCODE == "NONE"
  require 'active_support/core_ext/string/multibyte'
end


# StringUtils is a library that allows various string manipulation
# Example usage:
#   * StringUtils.truncate("hello world", 10, "...") #=> "hello..."
#   * StringUtils.normalize_name "\302\240  Gran Via/Avda.de Asturias " #=> :Gran Via / Avda. de Asturias"
module StringUtils
  extend self

  NBSP               = "\302\240"
  WHITESPACE_MATCHER = "(?:\s|#{NBSP})"
  WHITESPACE         = /#{WHITESPACE_MATCHER}/
  NOT_WHITESPACE     = "[^\s#{NBSP}]"
  WHITESPACES        = /#{WHITESPACE_MATCHER}+/


  # Normalizes whitespace
  # "a , a" => "a, a"
  # "a ,a"  => "a, a"
  # "a,a"   => "a, a"
  # "a/b"   => "a / b", "a/ b" => "a / b", "a /b" => "a / b"
  # Removes trailing and leading [.,]
  # options: {:titleize => true (default false)}
  def normalize_name(value, options = {})
    value = mb_charify(value)

    # Normalize whitespace
    value.gsub!("\n", ' ')
    value.gsub!(WHITESPACES, ' ')
    value.strip!

    # Remove trailing and leading .,
    value.gsub!(/^[.,]/, '')
    value.gsub!(/[.,]$/, '')

    # "a ,a"  => "a, a"
    # "a,a"   => "a, a"
    # "a , a" => "a, a"
    value.gsub!(/#{WHITESPACE_MATCHER}([,.])/, '\1')
    value.gsub!(/([,.])(#{NOT_WHITESPACE})/, '\1 \2')

    # "//" => "/"
    value.gsub!(/\/+/, '/')

    # "a/b" => "a / b", "a/ b" => "a / b", "a /b" => "a / b"
    value.gsub!(/(#{NOT_WHITESPACE})\//, '\1 /')
    value.gsub!(/\/(#{NOT_WHITESPACE})/, '/ \1')

    if options[:titleize]
      value = value.titleize
      value.gsub!(/#{WHITESPACE_MATCHER}(Of|And|A|An|The|To)#{WHITESPACE_MATCHER}/) { |m| "#{m.downcase}" }
    end
    value.to_s
  end

  # Truncates the string
  # The result will be +:length+ or shorter, and the words will not be cut in the middle
  # Arguments:
  # :length => Integer (default: 30)
  # :omission => String (default: "...")
  def truncate(text, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}

    # support either old or Rails 2.2 calling convention:
    unless args.empty?
      options[:length]   = args[0] || 30
      options[:omission] = args[1] || "…"
    end

    options          = {:length => 30, :omission => "…"}.merge(options)
    options[:length] = options[:length].to_i

    return "" if !text
    chars = mb_charify(text)


    # If we can return it straight away or rstrip it and return it, we do it here
    if chars.length <= options[:length]
      return text
    elsif (chars = rstrip_with_nbsp(chars)).length <= options[:length]
      return chars.to_s
    end

    omission           = mb_charify(options[:omission])

    # Here we know we have to remove at least 1 word
    # 1. Get the first l characters
    # 2. Remove the last word if it's a part
    # 3. Add omission
    length_wo_omission = options[:length] - omission.length

    return '' if length_wo_omission < 0

    result = rstrip_with_nbsp(chars[0...length_wo_omission] || "")

    # Remove the last word unless we happened to trim it exactly already
    unless chars[length_wo_omission] =~ WHITESPACE || result.length < length_wo_omission
      len    = result.split(WHITESPACES).last
      len    &&= len.length
      result = rstrip_with_nbsp(result[0...(result.length - (len || 0))])
    end

    result += options[:omission]
    result.to_s
  end

  # Returns a unicode compatible version of the string
  #
  # support any of:
  #  * ruby 1.9 sane utf8 support
  #  * rails 2.1 workaround for crappy ruby 1.8 utf8 support
  #  * rails 2.2 workaround for crappy ruby 1.8 utf8 support
  # hooray!
  def mb_charify(text)
    if RUBY_VERSION >= '1.9'
      text
    elsif text.respond_to?(:mb_chars)
      text.mb_chars
    else
      raise "StringUtils: No unicode support for strings"
    end
  end

  private

  def rstrip_with_nbsp(s)
    s.gsub(/#{WHITESPACE_MATCHER}+\z/, '')
  end
end
