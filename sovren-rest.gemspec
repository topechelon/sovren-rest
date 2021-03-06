# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: sovren-rest 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sovren-rest".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["TEN Devs V3".freeze]
  s.date = "2021-01-21"
  s.description = "Interfaces with the Sovren 9.0 REST API".freeze
  s.email = "tendevsv3@patriotsoftware.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".dependabot/config.yml",
    ".document",
    ".rspec",
    ".rubocop.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "docs/README_rdoc.html",
    "docs/SovrenRest.html",
    "docs/SovrenRest/AuthenticationError.html",
    "docs/SovrenRest/Category.html",
    "docs/SovrenRest/Category/Certification.html",
    "docs/SovrenRest/Category/ContactInformation.html",
    "docs/SovrenRest/Category/EducationHistory.html",
    "docs/SovrenRest/Category/EmploymentHistory.html",
    "docs/SovrenRest/Category/EmploymentPosition.html",
    "docs/SovrenRest/Category/Generic.html",
    "docs/SovrenRest/Client.html",
    "docs/SovrenRest/ClientException.html",
    "docs/SovrenRest/ClientException/GatewayTimeout.html",
    "docs/SovrenRest/ClientException/RestClientTimeout.html",
    "docs/SovrenRest/ConstraintError.html",
    "docs/SovrenRest/ConversionCorruptException.html",
    "docs/SovrenRest/ConversionEncryptedException.html",
    "docs/SovrenRest/ConversionException.html",
    "docs/SovrenRest/ConversionImageException.html",
    "docs/SovrenRest/ConversionNoTextException.html",
    "docs/SovrenRest/ConversionTimeoutException.html",
    "docs/SovrenRest/ConversionToOutputTextException.html",
    "docs/SovrenRest/ConversionUnsupportedFormatException.html",
    "docs/SovrenRest/CoordinatesNotFound.html",
    "docs/SovrenRest/DataNotFound.html",
    "docs/SovrenRest/DuplicateAsset.html",
    "docs/SovrenRest/InsufficientData.html",
    "docs/SovrenRest/InvalidParameter.html",
    "docs/SovrenRest/MissingParameter.html",
    "docs/SovrenRest/ParseResponse.html",
    "docs/SovrenRest/ParsingError.html",
    "docs/SovrenRest/RestClientTimeout.html",
    "docs/SovrenRest/Resume.html",
    "docs/SovrenRest/Unauthorized.html",
    "docs/SovrenRest/UnhandledException.html",
    "docs/created.rid",
    "docs/images/add.png",
    "docs/images/brick.png",
    "docs/images/brick_link.png",
    "docs/images/bug.png",
    "docs/images/bullet_black.png",
    "docs/images/bullet_toggle_minus.png",
    "docs/images/bullet_toggle_plus.png",
    "docs/images/date.png",
    "docs/images/delete.png",
    "docs/images/find.png",
    "docs/images/loadingAnimation.gif",
    "docs/images/macFFBgHack.png",
    "docs/images/package.png",
    "docs/images/page_green.png",
    "docs/images/page_white_text.png",
    "docs/images/page_white_width.png",
    "docs/images/plugin.png",
    "docs/images/ruby.png",
    "docs/images/tag_blue.png",
    "docs/images/tag_green.png",
    "docs/images/transparent.png",
    "docs/images/wrench.png",
    "docs/images/wrench_orange.png",
    "docs/images/zoom.png",
    "docs/index.html",
    "docs/js/darkfish.js",
    "docs/js/jquery.js",
    "docs/js/navigation.js",
    "docs/js/search.js",
    "docs/js/search_index.js",
    "docs/js/searcher.js",
    "docs/rdoc.css",
    "docs/table_of_contents.html",
    "index.html",
    "jenkins/release.jenkinsfile",
    "jenkins/test.jenkinsfile",
    "lib/sovren-rest.rb",
    "lib/sovren-rest/category/certification.rb",
    "lib/sovren-rest/category/contact_information.rb",
    "lib/sovren-rest/category/education_history.rb",
    "lib/sovren-rest/category/employment_history.rb",
    "lib/sovren-rest/category/employment_position.rb",
    "lib/sovren-rest/category/generic.rb",
    "lib/sovren-rest/client.rb",
    "lib/sovren-rest/exceptions.rb",
    "lib/sovren-rest/parse_response.rb",
    "lib/sovren-rest/resume.rb",
    "sovren-rest.gemspec",
    "spec/integration/files/resume.pdf",
    "spec/integration/parse_spec.rb",
    "spec/spec_helper.rb",
    "spec/unit/files/certification.json",
    "spec/unit/files/contact-info.json",
    "spec/unit/files/education-history.json",
    "spec/unit/files/employment-history.json",
    "spec/unit/files/experience-summary.json",
    "spec/unit/files/response.json",
    "spec/unit/files/resume.json",
    "spec/unit/sovren-rest/category/certification_spec.rb",
    "spec/unit/sovren-rest/category/contact_information_spec.rb",
    "spec/unit/sovren-rest/category/education_history_spec.rb",
    "spec/unit/sovren-rest/category/employment_history_spec.rb",
    "spec/unit/sovren-rest/category/employment_position_spec.rb",
    "spec/unit/sovren-rest/client_spec.rb",
    "spec/unit/sovren-rest/parse_response_spec.rb",
    "spec/unit/sovren-rest/resume_spec.rb"
  ]
  s.homepage = "http://github.com/SynergyDataSystems/sovren-rest".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Sovren 9.0 Rest".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rest-client>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-rcov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<rest-client>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-rcov>.freeze, [">= 0"])
  end
end

