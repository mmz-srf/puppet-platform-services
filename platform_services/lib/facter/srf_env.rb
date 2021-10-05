Facter.add("srf_env") do
  mpc_project = String.new(Facter.value('mpc_project'))
  setcode do
    case mpc_project
    when 'test'
      'dev'
    when 'stage'
      'int'
    when "production"
      'prd'
    else
      'undef'
    end
  end
end
