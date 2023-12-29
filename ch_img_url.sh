#!/bin/bash

set -exo pipefail

grep -rl '/assets/images' content/ | xargs sed -i 's/\/assets\/images/https:\/\/res.cloudinary.com\/peladen\/image\/upload\/v1612739828\/peladen/g' > /dev/null
