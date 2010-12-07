# -*- coding: utf-8 -*-
require "string_utils"

describe "StringUtils" do
  describe "#normalize_name" do

    it 'normalizes whitespace' do
      StringUtils.normalize_name("\302\240   Hello \302\240  World!   ").should == "Hello World!"
    end

    it 'normalizes periods, commas and /' do
      StringUtils.normalize_name("Av . Valle , Tetuan.Aqui ,a").should == "Av. Valle, Tetuan. Aqui, a"
    end

    it 'removes trailing and leading [,.]' do
      StringUtils.normalize_name(".Here,").should == "Here"
    end
  end
end
