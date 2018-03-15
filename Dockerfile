FROM node:alpine
RUN npm install -g jshint eslint js-beautify html-minifier
CMD [ "ash" ]
