# Use a base image
FROM debian:bullseye-slim

ARG user=palworld
ARG group=palworld
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/bash -m ${user}

RUN dpkg --add-architecture i386
RUN apt update; apt install -y ca-certificates-java
RUN apt update; apt install -y lib32gcc-s1 curl
RUN apt update; apt install -y openjdk-17-jre-headless

RUN mkdir -p /steamapps
RUN curl -sqL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxvf - -C /steamapps
WORKDIR /steamapps

RUN ./steamcmd.sh +force_install_dir '/app/PalServer/' +login anonymous +app_update 2394010 validate +quit
RUN ./steamcmd.sh +force_install_dir '/app/Steamworks SDK Redist/' +login anonymous +app_update 1007 +quit

RUN chown -R 1000:1000 /app
RUN chown -R 1000:1000 /home/palworld

USER ${uid}:${gid}
RUN mkdir -p ~/.steam/sdk64
RUN cp '/app/Steamworks SDK Redist/linux64/steamclient.so' ~/.steam/sdk64/
WORKDIR /app/PalServer

# Set the entry point for the container
CMD ["./PalServer.sh"]
