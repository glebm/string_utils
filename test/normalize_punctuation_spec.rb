# -*- coding: utf-8 -*-
require "string_utils"

describe "StringUtils" do
  describe "#normalize_punctuation" do

    it 'collapses commas' do
      StringUtils.normalize_punctuation("a,,b").should == "a, b"
    end

    it 'removes leading and trailing commas' do
      StringUtils.normalize_punctuation(" , ab  ,  ").should == "ab"
    end

    it 'fixes spacing around commas' do
      StringUtils.normalize_punctuation("a   ,    b").should == "a, b"
    end

  end
end