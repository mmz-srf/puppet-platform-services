# inspired by https://gist.github.com/elasticdog/5452797
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

Facter.add(:javaversion) do
  if File.exists?('/usr/bin/java')
    setcode do
      javaversion = %x[/usr/bin/java -version 2>&1 | awk '/version/ { print $3 }'].split('"')[1]
    end
  else
    setcode do
      javaversion = "java not installed"
    end
  end
end

Facter.add(:javamajversion) do
  javaversion = Facter.value(:javaversion)

  if javaversion == "java not installed"
    setcode do
      mdata = "java not installed"
    end
  else
    regexp = /\d+\.(\d+)\./
    setcode do
      mdata = regexp.match(javaversion)
      firstversion = mdata[0].split('.')[0]

      if firstversion.to_i >= 10
        majversion = firstversion
      else
        majversion = mdata[1]
      end
      mdata = majversion
    end
  end
end
