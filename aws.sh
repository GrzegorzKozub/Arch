set -e -o verbose

# aws

if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi

cp `dirname $0`/home/greg/.aws/config ~/.aws

cp -r /mnt/.arch/keys/aws/credentials ~/.aws

