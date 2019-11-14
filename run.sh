BRANCH="$1"

SCALA_VERSION=$(wget -q -O - https://raw.githubusercontent.com/scala/community-builds/$BRANCH/nightly.properties | grep '^nightly=' | cut -d '=' -f2)

echo "Branch: $BRANCH"
echo "Scala version: $SCALA_VERSION"

rm -rf shapeless/ && \
git clone https://github.com/milessabin/shapeless.git && \
cd shapeless && \
git checkout master && \
sbt 'set resolvers in Global += "scala-integration" at "https://scala-ci.typesafe.com/artifactory/scala-integration/"' ++$SCALA_VERSION validate
