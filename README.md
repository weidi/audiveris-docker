# audiveris-docker-images

This container will convert all jpg, png and pdf to mxl (MusicXML) so you can further edit it with tools like MuseScore.

All *.pdf, *.jpg and *.png in `/path/to/input` will be converted and saved to `/path/to/output`

Usage
-------------
`docker run --rm  -v /path/to/output:/output -v /path/to/input:/input toprock/audiveris`
