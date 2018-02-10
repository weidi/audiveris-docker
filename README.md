# audiveris-docker

This is the Repository for https://hub.docker.com/r/toprock/audiveris

This container will convert all your sheet music in PDF to mxl (MusicXML) so you can further edit it with tools like MuseScore.

All *.pdf in `/path/to/input` will be converted and saved to `/path/to/output`

Available Tags
---------
`latest` most of the commits to development branch

`stable` release flagged as stable


Usage
-------------
`docker run --rm  -v /path/to/output:/output -v /path/to/input:/input toprock/audiveris`
