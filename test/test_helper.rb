require "test/unit"

test = File.dirname(__FILE__)

$:.unshift(File.join(test, "lib", "hector", "lib"))
require "hector"

$:.unshift(File.join(test, "lib", "hector", "test"))
require "test_helper"

$:.unshift(File.join(test, "..", "lib"))
require "hector/wheaties"

require "logger"
WHEATIES_TEST_LOG_DIR = File.join(test, "..", "log")
Hector.logger = Logger.new(File.open(File.join(WHEATIES_TEST_LOG_DIR, "test.log"), "w+"))
