FROM ruby:3.2.2
RUN apt-get update && apt-get install -y build-essential imagemagick libvips ffmpeg mecab libmecab-dev mecab-ipadic-utf8
COPY ./config/imagemagick/policy.xml /etc/ImageMagick-6/policy.xml
RUN gem i -v 7.0.7 rails