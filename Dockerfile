FROM openjdk:11-slim as packager

# Build modules distribution
RUN jlink \
    --verbose \
    --add-modules java.base,java.sql,java.naming,java.management,java.security.jgss,java.instrument,jdk.crypto.ec,jdk.unsupported,jdk.jfr \
    --compress 2 \
    --strip-debug \
    --no-header-files \
    --no-man-pages \
    --output /opt/jre

# Second stage, add only our minimal "JRE" distr and our app
FROM debian:stable-slim

ENV JAVA_HOME=/usr/lib/jvm
ENV PATH="$PATH:$JAVA_HOME/bin"

COPY --from=packager /opt/jre $JAVA_HOME

# Remove suid & sgid files
RUN find /bin /etc /lib /sbin /usr -xdev -type f -a \( -perm /4000 -o -perm /2000 \) -delete

# Remove temp shadow,passwd,group
RUN find /bin /etc /lib /sbin /usr -xdev -type f -regex '.*-$' -exec rm -f {} +

ENTRYPOINT [ "java" ]
CMD [ "-version"]
