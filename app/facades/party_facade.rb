class PartyFacade
  def self.make_parties(invites, party_id)
    return if invites.nil?
    expected = invites.to_enum.to_h.find_all do |key, value|
      key if value != 'false'
    end.flatten.uniq
    expected.map do |friend|
      UserParty.create(
        user_id: friend,
        party_id: party_id
      )
    end
  end
end
