# This is the spec_helper required for use with Aruba.

require 'aruba/api';
require 'aruba/reporting';
require 'timeout';

RSpec.configure do |conf|
  conf.include Aruba::Api;
end

def runFandianpf
  # Given The default aruba timeout is 10 seconds
  @aruba_timeout_seconds = 10;
  # And I run `fandianpf -e test` interactively
  run_interactive(unescape("fandianpf -e test"));
  # And I wait for stdout to contain "Listening on tcp"
  Timeout::timeout(exit_timeout) do
    loop do
      break if assert_partial_output_interactive("Listening on tcp")
      sleep 0.1
    end
  end
  # And I kill all processes
  terminate_processes!
end

def ignoreErrors(&block)
  begin
    yield
  rescue
    # do nothing
  end
end

def announceArubaSteps
  @announce_stdout = true
  @announce_stderr = true
  @announce_cmd = true
  @announce_dir = true
  @announce_env = true
  announce_or_puts("");
end
