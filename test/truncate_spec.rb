# -*- coding: utf-8 -*-
require 'string_utils'

describe "StringUtils" do
  describe "#truncate" do

    it "does not cut words shorter than the truncate length" do
      tests = ["hello", "hello there this is a test nothing more"]
      tests.each do |test|
        StringUtils.truncate(test, test.length).should == test
      end
    end

    it "truncates even if the only word is longer than the truncate length" do
      StringUtils.truncate("hello", 3, "...").should == "..."
    end

    it "never goes above the length provided" do
      (0..2).each do |length|
        StringUtils.truncate("ɦɛĺłø ŵőřļđ", length, "...").should == ""
      end

      (3..7).each do |length|
        StringUtils.truncate("ɦɛĺłø ŵőřļđ", length, "...").should == "..."
      end

      (8..10).each do |length|
        StringUtils.truncate("ɦɛĺłø ŵőřļđ", length, "...").should == "ɦɛĺłø..."
      end

      (11..15).each do |length|
        StringUtils.truncate("ɦɛĺłø ŵőřļđ", length, "...").should == "ɦɛĺłø ŵőřļđ"
      end
    end

    it "keeps the whole word" do
      StringUtils.truncate("ab cd", 2, '.').should == "."
    end

    it "does not cut character entities" do
      StringUtils.truncate("&auml; &Auml;", 9, '..').should == "&auml;.."
    end

    it "handles empty strings" do
      StringUtils.truncate("", 0, "...").should == ""
      StringUtils.truncate("", 1, "...").should == ""
      StringUtils.truncate("", 30, "...").should == ""
    end
  end
end