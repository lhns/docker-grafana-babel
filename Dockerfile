FROM grafana/grafana:12.1.0

USER root

#RUN find public/ -type f -name '*.js' -not -path '*/dashboards/*' -exec grep -o '?\.' {} + | wc -l || true

RUN apk add nano npm \
 && npm install --save-dev @babel/core @babel/cli @babel/preset-env \
 && node_modules/.bin/babel public/ --out-dir public/ --ignore '*/dashboards/*' --plugins=@babel/plugin-transform-nullish-coalescing-operator,@babel/plugin-transform-optional-chaining,@babel/plugin-transform-private-methods,@babel/plugin-transform-class-static-block,@babel/plugin-transform-class-properties,@babel/plugin-transform-classes,@babel/plugin-transform-arrow-functions \
 && rm -Rf node_modules \
 && apk del npm

RUN echo "Removing negative lookbehinds..." \
 && find public/ -type f -name '*.js' -not -path '*/dashboards/*' -exec grep -Eo '.{0,10}\(\?<[!=].{0,60}' {} + -exec sed -Ei 's/(\(\?<![^)]*\))//g' {} +

USER 472
