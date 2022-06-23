#!/bin/sh

cp -f ./redbean-stock.com ./tempbean.com
chmod +x ./tempbean.com
chmod u+wx ./tempbean.com
cd ./srv
../zip.com -r ../tempbean.com ./
cd ..
