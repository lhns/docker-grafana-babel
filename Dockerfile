FROM grafana/grafana:11.2.0

USER root

RUN apk add npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && mkdir public2 \
 && node_modules/.bin/babel public/ --out-dir public2/ --ignore '*/dashboards/*' '--presets=["targets={safari:\"11.1\"}"]' --plugins @babel/plugin-transform-optional-chaining,@babel/plugin-transform-nullish-coalescing-operator \
 && rm -Rf node_modules \
 && apk del npm

RUN find public2/ -type f -exec grep -l '\\?\\.' {} + || true

USER 472
