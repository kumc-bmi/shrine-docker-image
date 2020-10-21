# shrine-docker-image

A docker image for the [Shared Health Research Information Network](https://open.catalyst.harvard.edu/wiki/display/SHRINE/Welcome) software.

The goal of this project is solely to provide a base image for the SHRINE software while adhering to Docker community norms.  It is up to the user to reason about deployment.

## Usage

See the top of `init.sh` for required environment variables.  Use the container deployment tool of your choice to supply these securely, or build off of `docker-compose.yml`.

Depending on your choice of database, you will need an appropriate jdbc driver.  If `SHRINE_JDBC_PATH` is a url, it will be downloaded.  Otherwise, `SHRINE_JDBC_PATH` needs to be a filesystem path populated by a method of your choosing.

`shrine.conf.j2` is expected to exist at `/opt/templates/shrine.conf.j2`.  This can be mapped in as follows:

```
    volumes:
     - ./shrine-hub.conf.j2:/opt/templates/shrine.conf.j2
```

## License and Acknowledgments

The SHRINE software is [distributed under](https://open.catalyst.harvard.edu/wiki/display/SHRINE/Software+Downloads) the [three-clause BSD license](https://opensource.org/licenses/BSD-3-Clause).

This work was conducted with support from Harvard Catalyst | The Harvard Clinical and Translational Science Center (National Center for Research Resources and the National Center for Advancing Translational Sciences, National Institutes of Health Award 1UL1 TR001102-01 and financial contributions from Harvard University and its affiliated academic healthcare centers. If you have used SHRINE after May 1, 2018, please replace the above grant number with: UL1TR002541). The content is solely the responsibility of the authors and does not necessarily represent the official views of Harvard Catalyst, Harvard University and its affiliated academic healthcare centers, or the National Institutes of Health.
