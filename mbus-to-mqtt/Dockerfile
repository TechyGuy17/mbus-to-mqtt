ARG BUILD_FROM
FROM $BUILD_FROM


COPY . /src
WORKDIR /src
RUN ["pwd", "&&", "chmod", "+x", "fetch_meters.sh", "&&", "mv", "fetch_meters.sh", ".."]

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
    yq-go

#RUN pip3 install yq

RUN git clone https://github.com/rscada/libmbus

RUN cd libmbus && ./build.sh && ./configure && make -j4 && make install

# Add the cron job
RUN crontab -l | { cat; echo "*/30 * * * * bash /fetch_meters.sh"; } | crontab -

CMD crond -f


