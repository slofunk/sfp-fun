#!/bin/bash

 VENDOR="HACKSHACK-INC   "

 SERIAL="8675309         "

 #manufacturer id is already 2 because finisar but this is not a "cisco finisar"

 MD5SUM="md5sumgoeshere"

 CRC32="CRC32goeshere""


echo "Unlocking module"
./myunlock.sh
sleep 1

#remember we start at 0
# write vendor
echo "Writing vendor"
writeaddr=20
for chr in $(printf "${VENDOR}" | xxd -p -c1); do
	i2cset -y 1 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
	sleep 0.05
	writeaddr=$((writeaddr+1))
done

# write serial
echo "Writing serial"
writeaddr=68
for chr in $(printf "${SERIAL}" | xxd -p -c1); do
	i2cset -y 1 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
	sleep 0.05
	writeaddr=$((writeaddr+1))
done

# write md5sum 
echo "Writing md5sum"
writeaddr=99
for chr in $(printf "${MD5SUM}" | sed -E 's/(.{2})/\1\n/g'); do
        i2cset -y 1 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
        sleep 0.05
        writeaddr=$((writeaddr+1))
done

# write crc32 
echo "Writing crc32"
writeaddr=124
for chr in $(printf "${CRC32}" | sed -E 's/(.{2})/\1\n/g'); do
        i2cset -a -y 1 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
        sleep 0.05
        writeaddr=$((writeaddr+1))
done
