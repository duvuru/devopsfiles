# Forcing ipv4
echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4
# Installing Puppet
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get install -y puppet-agent git
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
# Installing Sonar
sudo puppet module install fraenki-sonarqube
wget https://gitlab.com/roybhaskar9/devops/raw/master/release/jenkins/jenkinsserver/sonar.pp
sudo puppet apply sonar.pp
sudo echo "sonar.embeddedDatabase.port:               9092" >> /usr/local/sonar/conf/sonar.properties
sudo /etc/init.d/sonar start
# Installing Maven
sudo apt-get install -y maven
sudo rm -f /etc/maven/settings.xml
sudo wget https://raw.githubusercontent.com/roybhaskar9/samplejava/master/settings.xml -O /etc/maven/settings.xml
# Installing Nexus
sudo puppet module install hubspot-nexus
wget https://gitlab.com/roybhaskar9/devops/raw/master/release/jenkins/jenkinsserver/nexus.pp
sudo puppet apply nexus.pp
# Installing Jenkins
#sudo puppet module install rtyler-jenkins
#wget https://gitlab.com/roybhaskar9/devops/raw/master/release/jenkins/jenkinsserver/jenkins.pp
#sudo puppet apply jenkins.pp
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y jenkins



