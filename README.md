<!-- [![dockeri.co](http://dockeri.co/image/_/arangodb)](https://registry.hub.docker.com/_/arangodb/) -->

# ArangoDB
ArangoDB is a distributed open-source database with a flexible data model for documents, graphs, and key-values. You can build high performance applications using a convenient SQL-like query language or JavaScript extensions.

The official image is based on Alpine which might give you performance issue when doing I/O intensive operations, hence this customisation was desired.

## References

- [Database Documentation](https://www.arangodb.com/docs/stable/)
- [Tutorials](https://www.arangodb.com/learn/)
- [Deployment guides](https://www.arangodb.com/docs/stable/deployment.html)
- [Deployment using Starter](https://www.arangodb.com/docs/stable/deployment-arango-dbstarter.html)
- [Official Docker Hub Guide](https://registry.hub.docker.com/r/arangodb/arangodb)

Substitute official image with [you desired tag from Docker Hub](https://hub.docker.com/r/sandeepk01/arangodb) instead inside commands in your installation instructions.

## License
[ArangoDB is released under Apache license](https://github.com/arangodb/arangodb/blob/devel/LICENSE) and may contain various third party software under their respective license. These images are created on top of NodeJS official docker images which contain software with respective licenses. It is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

## Credits

All thanks to [ArangoDB team](https://www.arangodb.com/about-arangodb/) for creating this simpler (DX wise) yet powerful database.