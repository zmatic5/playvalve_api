class BanStatusEnumeration < Enumerations::Base
  value :banned, id: 1, label: 'Banned'
  value :not_banned, id: 2, label: 'Not Banned'
end
