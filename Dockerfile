FROM ubuntu:latest

#Set locales
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN apt-get update && apt-get install -y curl wget

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb

RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

RUN apt-get install -y tzdata && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get install -y postgresql nodejs npm esl-erlang elixir git inotify-tools



RUN git clone https://github.com/sergiotapia/magnetissimo.git




#Setup postgres
USER postgres
RUN /etc/init.d/postgresql start &&\
     psql --command "CREATE USER torrent WITH PASSWORD 'torrentz';" &&\
     psql --command "CREATE DATABASE torrent OWNER torrent;" &&\
     psql --command "ALTER USER torrent CREATEDB;"

USER root

###OLD### |
#	  V	

#Set locale
#storage of passwords and such
#automae mix setup stuff

COPY dev.exs /magnetissimo/config/dev.exs

COPY setupmix.sh /setupmix.sh

RUN chmod +x /setupmix.sh

RUN /setupmix.sh

EXPOSE 4000

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]

#CMD ["/usr/bin/local/mix", "phoenix.server"]


