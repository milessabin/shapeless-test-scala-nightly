SCALA_BRANCH="$1"
SHAPELESS_BRANCH="$2"

SCALA_VERSION=$(wget -q -O - https://raw.githubusercontent.com/scala/community-builds/$SCALA_BRANCH/nightly.properties | grep '^nightly=' | cut -d '=' -f2)
SUFFIX=$(echo $SCALA_BRANCH | tr '.' '_' | cut -d '_' -f1-2)

echo "Scala branch: $SCALA_BRANCH"
echo "Scala version: $SCALA_VERSION"
echo "Project suffix: $SUFFIX"
echo "shapeless branch: $SHAPELESS_BRANCH"

case $SHAPELESS_BRANCH in
  main)
    TESTS="validateJVM"
    ;;
  *)
    echo "Unknown shapeless branch $SHAPELESS_BRANCH"
    exit 1
esac

echo "Tests:" $TESTS

rm -rf shapeless/ && \
git clone https://github.com/milessabin/shapeless.git && \
cd shapeless && \
git checkout $SHAPELESS_BRANCH && \
sbt 'set resolvers in Global += "scala-integration" at "https://scala-ci.typesafe.com/artifactory/scala-integration/"' ++$SCALA_VERSION $TESTS
