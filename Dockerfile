FROM grafana/grafana:11.2.0

USER root

RUN find public/ -type f -name '*.js' -not -path '*/dashboards/*' -exec grep -o '?\.' {} + | wc -l || true

RUN apk add nano npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && mkdir public2/ \
 && node_modules/.bin/babel public/ --out-dir public/ --ignore '*/dashboards/*' --plugins=@babel/plugin-transform-nullish-coalescing-operator,@babel/plugin-transform-optional-chaining,@babel/plugin-transform-class-static-block,@babel/plugin-transform-class-properties,@babel/plugin-transform-classes,@babel/plugin-transform-arrow-functions \
 && find public/ -type f -name '*.js' -not -path '*/dashboards/*' -exec sed -i 's/(?<!:)//g' {} + \
 && rm -Rf node_modules \
 && apk del npm

RUN find public/ -type f -name '*.js' -not -path '*/dashboards/*' -exec grep -o '?\.' {} + | wc -l || true

USER 472
