class Note < ApplicationRecord
  belongs_to :job

  enum category: { applied: 1, interview: 2, test: 3, call: 4, general: 99 }, _default: "general"
end
