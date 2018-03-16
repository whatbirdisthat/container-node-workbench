FROM node:alpine

RUN npm install -g jshint eslint js-beautify html-minifier pug-cli gulp-cli

RUN apk --no-cache add autoconf build-base libpng-dev nasm file automake
RUN npm install -g --unsafe-perm=true --allow-root imagemin imagemin-gifsicle imagemin-optipng imagemin-jpegtran imagemin-svgo imagemin-cli

CMD [ "ash" ]
