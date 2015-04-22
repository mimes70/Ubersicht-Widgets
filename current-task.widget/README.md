## Para instalar o Ubersicht:
 1. Download do site: http://tracesof.net/uebersicht/ e instalar em /Applications
 2. Correr inicialmente inalterado
 3. cd /Applications/Übersicht.app/Contents/Resources
 4. Instalar a dependência do "toggl-api": ```npm install toggl-api```
 5. Aplicar o patch1: ```patch server.js [widgetpath]/server.patch```
 6. Aplicar o patch2: ```patch server.js [widgetpath]/toggl_api_auth.path```

## Para inicialmente criar o patch usar:
```diff -u server.original.js server.modified.js > server.patch```
