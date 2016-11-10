class Card < ApplicationRecord
  belongs_to :hand, optional: true
end
