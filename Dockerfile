FROM grafana/grafana:11.2.0

RUN apk add npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && node_modules/.bin/babel public/ --out-dir public/ --ignore '*/dashboards/*' --presets=@babel/env \
 && rm -Rf node_modules \
 && apk del npm
