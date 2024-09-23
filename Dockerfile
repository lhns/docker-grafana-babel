FROM grafana/grafana:11.2.0

USER root

RUN find public/ -type f -not -path '*/dashboards/*' -exec grep -o '\\?\\.' {} + | wc -l || true

RUN apk add npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && node_modules/.bin/babel public/ --out-dir public/ --ignore '*/dashboards/*' --plugins=@babel/plugin-transform-optional-chaining,@babel/plugin-transform-nullish-coalescing-operator \
 && rm -Rf node_modules \
 && apk del npm

RUN find public/ -type f -not -path '*/dashboards/*' -exec grep -o '\\?\\.' {} + | wc -l || true

USER 472
