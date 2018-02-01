FROM debian as builder
RUN apt-get update && apt-get install gradle \
        default-jdk \
        git \
        tesseract-ocr -y

RUN git clone https://github.com/Audiveris/audiveris.git && cd audiveris && gradle clean build -x test
RUN mkdir /Audiveris && tar -xvf /audiveris/build/distributions/Audiveris.tar -C /Audiveris


FROM debian:stable-slim
COPY --from=builder /Audiveris/ /

RUN mkdir -p /usr/share/man/man1 && apt-get update && apt-get install --no-install-recommends \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-deu \
        tesseract-ocr-fra \
        openjdk-8-jre-headless -y && \
        rm /etc/java-8-openjdk/accessibility.properties

CMD ["sh", "-c", "/Audiveris/bin/Audiveris -batch -export -output /output /input/*.pdf"]
