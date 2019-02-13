# inspired by ttps://gist.github.com/elasticdog/5452797
#
# Fact: javaversion & javamajversion
#
# Purpose:
#   Return the version of the installed Java package in both its full form and
#   just the major release version.
#
# Resolution:
#   Uses the output from the `java -version` command to establish the full
#   version, and then parses that value to return just the major version
#   number. It will return the full javaversion if the major version could not
#   be parsed out.
#
# Caveats:
#

Facter.add(:javaversion) do
  setcode do
    javaversion = %x[/usr/bin/java -version 2>&1 | awk '/version/ { print $3 }'].split('"')[1]
  end
end

Facter.add(:javamajversion) do
  regexp = /\d+\.(\d+)\./

  setcode do
    javaversion = Facter.value(:javaversion)
    mdata = regexp.match(javaversion)
    mdata ? mdata[1] : javaversion
  end
end
