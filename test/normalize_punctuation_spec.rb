# -*- coding: utf-8 -*-
require 'string_utils'

describe 'StringUtils' do
  describe '#normalize_punctuation' do
    describe 'removes trailing and leading:' do
      it 'commas' do
        StringUtils.normalize_punctuation(' , ab  ,  ').should == 'ab'
      end
    end
    
    describe 'transforms whitespace to 0 left-side and 1 right-side whitespace characters'do
      it 'commas' do
        StringUtils.normalize_punctuation('a  ,    b').should == 'a, b'
        StringUtils.normalize_punctuation('a ,b').should == 'a, b'
        StringUtils.normalize_punctuation('a,b').should == 'a, b'
      end
      
      it 'normalizes whitespace around semicolons (:)' do
        StringUtils.normalize_punctuation('a  :    b').should == 'a: b'
        StringUtils.normalize_punctuation('a :b').should == 'a: b'
        StringUtils.normalize_punctuation('a:b').should == 'a: b'
      end
      
      it 'normalizes whitespace around ampersands (&)' do
        StringUtils.normalize_punctuation('a&b').should == 'a & b'
        StringUtils.normalize_punctuation('a    &  b').should == 'a & b'
        StringUtils.normalize_punctuation('a    &b').should == 'a & b'
        StringUtils.normalize_punctuation('a&  b').should == 'a & b'
      end
    end

    describe 'collapses consecutive:' do
      it 'commas' do
        StringUtils.normalize_punctuation('a,,b').should == 'a, b'
      end
    end
  end
end