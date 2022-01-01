# audiveris-docker-images

This container will convert all images in jpg or png (originally forked repo: PDF) to mxl (MusicXML) so you can further edit it with tools like MuseScore.

All *.pdf in `/path/to/input` will be converted and saved to `/path/to/output`

Usage
-------------
`docker run --rm  -v /path/to/output:/output -v /path/to/input:/input toprock/audiveris`
