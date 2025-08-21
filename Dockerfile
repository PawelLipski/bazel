FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk-headless
RUN java -version
RUN apt-get install -y wget
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.27.0/bazelisk-linux-amd64 -qO /usr/local/bin/bazel
RUN chmod +x /usr/local/bin/bazel
RUN apt-get install -y build-essential
RUN apt-get install -y zip
RUN gcc --version
WORKDIR bazel
COPY . .
RUN bazel build //src:java_tools_zip
RUN ls -l bazel-bin/src/java_tools/buildjar/JavaBuilder_deploy.jar
RUN cp bazel-bin/src/java_tools/buildjar/JavaBuilder_deploy.jar /tmp
WORKDIR /tmp
RUN unzip JavaBuilder_deploy.jar
RUN javap -v com/google/devtools/build/buildjar/BazelJavaBuilder.class | head
