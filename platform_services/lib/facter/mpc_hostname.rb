Facter.add("mpc_hostname") do
  hostname = String.new(Facter.value('hostname'))
  mpc_hostname = hostname
  setcode do
    if mpc_hostname
      mpc_hostname
    else
      'undef'
    end
  end
end
