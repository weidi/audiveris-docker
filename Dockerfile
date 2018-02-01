FROM debian as builder
LABEL version="0.3"

RUN apt-get update && apt-get install gradle \
        default-jdk \
        git \
        tesseract-ocr -y

RUN git clone https://github.com/Audiveris/audiveris.git && cd audiveris && gradle clean build -x test


FROM debian
COPY --from=builder /audiveris/build/distributions/Audiveris.tar .

RUN apt-get update && apt-get install --no-install-recommends \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-deu \
        tesseract-ocr-fra \
        openjdk-8-jre-headless -y && tar -xvf Audiveris.tar && \
        rm /etc/java-8-openjdk/accessibility.properties && \
        rm Audiveris.tar

CMD ["sh", "-c", "/Audiveris/bin/Audiveris -batch -export -output /output /input/*.pdf"]
