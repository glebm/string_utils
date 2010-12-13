# -*- coding: utf-8 -*-
require "string_utils"

describe "StringUtils" do
  describe "#urlify" do

    it 'replaces known entities' do
      StringUtils.urlify("tschuß").should == "tschuss"
    end

    it 'uses :whitespace_replacement' do
      StringUtils.urlify("a b", :whitespace_replacement => "-x-").should == "a-x-b"
    end

    it 'uses :default_replacement' do
      StringUtils.urlify("%", :default_replacement => "A").should == "A"
    end
  end
end