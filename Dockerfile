FROM grafana/grafana:11.2.0

USER root

RUN apk add npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && node_modules/.bin/babel public/ --out-dir public/ --ignore '*/dashboards/*' --plugins @babel/plugin-transform-nullish-coalescing-operator,@babel/plugin-transform-optional-chaining \
 && find public/ -type f -exec grep -l '\\?\\.' {} + \
 && rm -Rf node_modules \
 && apk del npm

USER 472
