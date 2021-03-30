class PartyFacade
  def self.make_parties(invites, party)
    expected = invites.find_all do |key, value|
      key if value != "false"
    end.flatten.uniq
    expected.map do |friend|
      UserParty.create(
        user_id: friend,
        party_id: party
      )
    end
  end
end