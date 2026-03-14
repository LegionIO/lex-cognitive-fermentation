# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveFermentation
      class Client
        include Runners::CognitiveFermentation

        def initialize
          @default_engine = Helpers::FermentationEngine.new
        end
      end
    end
  end
end
