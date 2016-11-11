class Card < ActiveRecord::Base
  belongs_to :hand, optional: true
end
