ARG BUILD_FROM
FROM $BUILD_FROM

ENV CONFIG_PATH=/data/options.json

SHELL ["/bin/bash", "-l", "-c"]

COPY ["fetch_meters.sh", "/"] 

RUN chmod +x /fetch_meters.sh

RUN apk add --no-cache --virtual .build-dependencies \ 
    make \
    automake \
    autoconf \
    libtool \
    g++ \
    git \
    mosquitto-clients \
    jq \
    py3-pip \
    bash \
    pipx

RUN pipx install yq && pipx ensurepath 

RUN source ~/.bashrc

RUN git clone https://github.com/rscada/libmbus

RUN cd libmbus && ./build.sh && ./configure && make -j4 && make install

# Add the cron job
RUN crontab -l | { cat; echo "*/15 * * * *  bash /fetch_meters.sh"; } | crontab -

CMD crond -f


