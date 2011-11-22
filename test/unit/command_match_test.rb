require "test_helper"

module Hector
  class CommandMatchTest < TestCase
    def setup
      @service = Wheaties::Service.new("Wheaties")
      @service.prefix = /[!\.]/
    end
    
    test "matching prefix" do
      assert_matched :prefix => ".", :input => ".foo"
      assert_matched :prefix => "!", :input => "!foo"
    end
    
    test "non matching prefix" do
      assert @service.prefix !~ "@"
      refute_matched "@foo"
      refute_matched "@foo bar"
    end
    
    test "matching command name" do
      assert_matched :command => "foo", :input => ".foo"
    end
    
    test "matching args" do
      assert_matched :command => "foo", :args => "bar", :input => ".foo bar"
    end
    
    test "matching target" do
      assert_matched :args => "bar", :target => "baz", :input => ".foo bar > baz"
      assert_matched :args => "bar", :target => "baz", :input => ".foo bar > baz "
      assert_matched :args => "bar ", :target => "baz", :input => ".foo bar  >  baz"
      assert_matched :args => "bar", :target => "baz", :input => ".foo bar >> baz"
      assert_matched :args => "bar\\ ", :target => "baz", :input => ".foo bar\\  > baz"
      assert_matched :args => "bar", :target => "#baz", :input => ".foo bar > #baz"
    end
    
    test "no target" do
      assert_matched :args => "bar", :target => nil, :input => ".foo bar"
    end
    
    private
      def assert_matched(options)
        match = @service.match(options.delete(:input))
        assert match, "command did not match"
        options.each do |key, value|
          assert_equal value, match.send(key)
        end if match
      end
      
      def refute_matched(input)
        refute @service.match(input)
      end
  end
end
