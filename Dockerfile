FROM debian as builder
RUN apt-get update && apt-get install gradle \
        default-jdk \
        git \
        tesseract-ocr -y

RUN git clone --branch development https://github.com/Audiveris/audiveris.git && \
        cd audiveris && \
        ./gradlew build && \
        mkdir /Audiveris && \
        tar -xvf /audiveris/build/distributions/Audiveris.tar -C /Audiveris && \
        cd /Audiveris/Audiveris/lib/ && \
        rm -rf hdf5-1.10.0-patch1-1.3-linux-ppc64le.jar  hdf5-1.10.0-patch1-1.3-macosx-x86_64.jar hdf5-1.10.0-patch1-1.3-windows-x86.jar hdf5-1.10.0-patch1-1.3-windows-x86_64.jar leptonica-1.73-1.3-android-arm.jar leptonica-1.73-1.3-android-x86.jar leptonica-1.73-1.3-linux-armhf.jar leptonica-1.73-1.3-linux-ppc64le.jar  leptonica-1.73-1.3-macosx-x86_64.jar  leptonica-1.73-1.3-windows-x86.jar  leptonica-1.73-1.3-windows-x86_64.jar openblas-0.2.19-1.3-android-arm.jar  openblas-0.2.19-1.3-android-x86.jar openblas-0.2.19-1.3-linux-armhf.jar openblas-0.2.19-1.3-linux-ppc64le.jar openblas-0.2.19-1.3-macosx-x86_64.jar openblas-0.2.19-1.3-windows-x86.jar openblas-0.2.19-1.3-windows-x86_64.jar opencv-3.1.0-1.3-android-arm.jar opencv-3.1.0-1.3-android-x86.jar opencv-3.1.0-1.3-linux-armhf.jar opencv-3.1.0-1.3-linux-ppc64le.jar opencv-3.1.0-1.3-macosx-x86_64.jar opencv-3.1.0-1.3-windows-x86.jar opencv-3.1.0-1.3-windows-x86_64.jar


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
