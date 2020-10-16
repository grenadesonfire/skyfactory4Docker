FROM java:8-jre

# Setting workdir
WORKDIR /minecraft

# Changing user to root
USER root

#COPY ./ServerFiles /minecraft

# Creating user and downloading files
RUN useradd -m -U minecraft && \
	wget https://media.forgecdn.net/files/3012/800/SkyFactory-4_Server_4.2.2.zip && \
	unzip SkyFactory-4_Server_4.2.2.zip && \
	rm SkyFactory-4_Server_4.2.2.zip && \
	mkdir -p /minecraft/world && \
	chmod u+x /minecraft/Install.sh && \
	chmod u+x /minecraft/ServerStart.sh && \
	echo eula=true > /minecraft/eula.txt && \
	chown -R minecraft:minecraft /minecraft
USER minecraft

# Running install
RUN /minecraft/Install.sh

# Expose port 25565
EXPOSE 25565

# Expose journeymap 
EXPOSE 8080

# Expose volume
VOLUME ["/minecraft/world"]

# Start server
CMD ["/bin/bash", "/minecraft/ServerStart.sh"]