FROM debian:stretch-slim

RUN apt-get update && apt-get install -y  \
        curl \
        wget \
        git \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-deu \
        tesseract-ocr-fra

RUN wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb \
        && apt install -y ./jdk-17_linux-x64_bin.deb \
        && rm ./jdk-17_linux-x64_bin.deb

ENV JAVA_HOME=/usr/lib/jvm/jdk-17/ 
ENV PATH=$PATH:$JAVA_HOME/bin 

RUN  git clone --branch development https://github.com/Audiveris/audiveris.git && \
        cd audiveris && \
        ./gradlew build && \
        mkdir /audiveris-extract && \
        tar -xvf /audiveris/build/distributions/Audiveris*.tar -C /audiveris-extract && \
        mv /audiveris-extract/Audiveris*/* /audiveris-extract/ &&\
        rm -r /audiveris

CMD ["sh", "-c", "/audiveris-extract/bin/Audiveris -batch -export -output /output/ $(ls /input/*.jpg /input/*.png /input/*.pdf)"]
