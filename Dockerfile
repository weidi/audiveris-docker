FROM alpine as builder
RUN apk add --no-cache openjdk17 \
        git \
        tesseract-ocr  \
		ttf-dejavu \
		tar
RUN git clone --branch development https://github.com/Audiveris/audiveris.git && \
        cd audiveris && \
        ./gradlew build && \
		mkdir /audiveris-extract && \
        tar -xvf /audiveris/build/distributions/Audiveris*.tar -C /audiveris-extract && \
		mv /audiveris-extract/Audiveris*/* /audiveris-extract/

FROM alpine 
COPY --from=builder /audiveris-extract /audiveris-extract
RUN apk add --no-cache openjdk17-jre \
		freetype \
		libstdc++ \
		font-bh-ttf \
		libuuid && \
		ln -s /usr/lib/libfontconfig.so.1 /usr/lib/libfontconfig.so && \
		ln -s /lib/libuuid.so.1 /usr/lib/libuuid.so.1 && \
		#ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1 &&\
		ln -s /lib/ld-musl-x86_64.so.1 /usr/lib/ld-musl-x86_64.so.1 &&\
		mkdir /usr/share/tessdata/ &&\
		wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/deu.traineddata -O /usr/share/tessdata/deu.traineddata &&\
		wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.traineddata -O /usr/share/tessdata/eng.traineddata &&\
		wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/fra.traineddata -O /usr/share/tessdata/fra.traineddata 
ENV LD_LIBRARY_PATH /usr/lib
CMD ["sh", "-c", "/audiveris-extract/bin/Audiveris -batch -export -output /output/jpg /input/*.jpg"]
CMD ["sh", "-c", "/audiveris-extract/bin/Audiveris -batch -export -output /output/png /input/*.png"]
CMD ["sh", "-c", "/audiveris-extract/bin/Audiveris -batch -export -output /output/pdf /input/*.pdf"]
