class Movie < ApplicationRecord
    validates :title, presence: true
    validates :release_year, presence: false
end
