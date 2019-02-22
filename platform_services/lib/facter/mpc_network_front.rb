ip_segment_map = {
  'srf' => {
    'test'       => '20',
    #'acceptance' => '24',
    'stage'      => '28',
    #'training'   => '32',
    'production' => '36',
    'development'=> '16',
  },
  'rts' => {
    'dev'  => '6',
    'test' => '5',
    'prod' => '4',
  },
  'rsi' => {
    'test'    => '9',
    'staging' => '8',
    'prod'    => '7',
  },
  'stxt' => {
    'integration' => '1',
  },
}

Facter.add("mpc_network_front") do
  setcode do
    fact = nil
    mpc_bu = Facter.value('mpc_bu')
    mpc_project = Facter.value('mpc_project')
    mpc_zone = Facter.value('mpc_zone')

    begin
      network_id = ip_segment_map[mpc_bu][mpc_project]
    rescue NoMethodError
      network_id = nil
    end

    if network_id
      case mpc_zone
      when 'bie'
        fact = "10.101.#{network_id}.0"
      when 'zrh'
        fact = "10.102.#{network_id}.0"
      end
    else
      if mpc_bu == 'stxt' and mpc_project == 'test' then
        fact = '10.100.212.0'
      end
    end

    fact
  end
end
