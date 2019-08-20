FROM rocker/tidyverse:latest

# Change environment to Japanese(Character and DateTime)
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install ipaexfont
RUN apt update && apt install -y \
  fonts-ipaexfont

# Install some packages

RUN apt install -y vim openjdk-8-jdk libv8-3.14-dev libxml2-dev libcurl4-openssl-dev libssl-dev

# Install packages
RUN Rscript -e "install.packages(c('xgboost', 'h2o', 'V8', 'huge', 'Matrix', 'lme4', 'githubinstall', 'ranger', 'rstan', 'ggmcmc', 'bayesplot', 'brms', 'rstanarm', 'dlm', 'KFAS', 'bsts', 'BNSL', 'fitdistrplus'))"

CMD ["/init"]
