class UserParty < ApplicationRecord
  belongs_to :party
  belongs_to :user

  def self.invite_friends(invited_friends, party_id)
    invited_friends.map do |friend|
      UserParty.create(
        user_id: friend.first.to_i,
        party_id: party_id
      )
    end
  end
end