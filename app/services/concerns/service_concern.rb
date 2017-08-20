module Concerns
  module ServiceConcern
    extend ActiveSupport::Concern

    included do
      include Dry::Monads::Either::Mixin
      include Dry::Monads::Try::Mixin
    end
  end
end
