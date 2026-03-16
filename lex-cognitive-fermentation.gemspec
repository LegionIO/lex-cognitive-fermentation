# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_fermentation/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-fermentation'
  spec.version       = Legion::Extensions::CognitiveFermentation::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']
  spec.summary       = 'Slow unconscious cognitive processing for LegionIO agents'
  spec.description   = 'Models cognitive fermentation — the slow transformation of raw ideas ' \
                       'into refined insights through unconscious incubation and catalysis'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-fermentation'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata = {
    'homepage_uri'          => spec.homepage,
    'source_code_uri'       => spec.homepage,
    'documentation_uri'     => "#{spec.homepage}/blob/master/README.md",
    'changelog_uri'         => "#{spec.homepage}/blob/master/CHANGELOG.md",
    'bug_tracker_uri'       => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
