#!/bin/zsh
# Start off in the Bitwig extensions folder
cd ~/Documents/Bitwig\ Studio/Extensions
# Remove existing ~/Documents/Bitwig Studio/Extensions/JavaVsScala
rm -rf ~/Documents/Bitwig\ Studio/Extensions/JavaVsScala
# Create new ~/Documents/Bitwig Studio/Extensions/JavaVsScala
mkdir ~/Documents/Bitwig\ Studio/Extensions/JavaVsScala
# Relocate to ~/Documents/Bitwig Studio/Extensions/JavaVsScala
cd ~/Documents/Bitwig\ Studio/Extensions/JavaVsScala
# Move results of Java `mvn install`
cp ~/Code/Java/MidiMixJava/target/MidiMix.bwextension .
# Move results of Scala `sbt Assembly`
cp ~/Code/Scala/midimix/target/scala-3.3.0/MidiMix-assembly-0.1.0-SNAPSHOT.jar .
# Rename Java bwextension to Java zip
mv -f ./MidiMix.bwextension ./Java_MidiMix.zip
# Rename Scala jar to Scala zip
mv ./MidiMix-assembly-0.1.0-SNAPSHOT.jar ./Scala_MidiMix.zip
# Unzip Java_MidiMix.zip
unzip Java_MidiMix.zip -d Java_MidiMix
# Unzip Scala_MidiMix.zip
unzip Scala_MidiMix.zip -d Scala_MidiMix
# Merge the Java META-INF folder into the Scala META-INF folder
cp -R ./Java_MidiMix/META-INF/* ./Scala_MidiMix/META-INF
# Remove old Scala_MidiMix.zip
rm -rf ./Scala_MidiMix.zip
# Zip the Scala package back into Scala_MidiMix.zip
zip -r Scala_MidiMix.zip ./Scala_MidiMix
# Copy and rename the new Scala_MidiMix.zip to MidiMix.bwextension and put it back in cd ~/Documents/Bitwig\ Studio/Extensions
cp ./Scala_MidiMix.zip ../MidiMix.bwextension
 