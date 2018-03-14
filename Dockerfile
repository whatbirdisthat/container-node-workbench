FROM node:alpine
RUN npm install -g jshint eslint js-beautify
CMD [ "ash" ]
