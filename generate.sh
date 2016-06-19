#!/usr/bin/env bash

#
# Generate English-to-Japanese pairs from JMdict.
#
# License of this script: Apache License, Version 2.0
# License of the output: Creative Commons Attribution-ShareAlike License, Version 3.0 (see README.md)
#

# download JMdict
curl http://ftp.monash.edu.au/pub/nihongo/JMdict_e.gz | gzip -dc > JMdict_e.xml

# bundle install
bundle install --path bundler

# execute conversion
bundle exec ruby e2j_dict.rb JMdict_e.xml "e2j_`date +%Y%m%d%H%M%S`.json"

# clean up
rm JMdict_e.xml
