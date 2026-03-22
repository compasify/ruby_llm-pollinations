# frozen_string_literal: true

require 'ruby_llm-pollinations'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.order = :random
end

RSpec.shared_context 'with configured RubyLLM' do
  before do
    RubyLLM.configure do |c|
      c.pollinations_api_key = 'test-key'
    end
  end
end
