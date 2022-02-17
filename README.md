# Airbnb Fork

This section contains information specific to the airbnb fork.
The other sections are from the original bazel version.

## Version Naming Convention

I.e., if we patch 4.2.2, then the tag and branch is 4.2.2-airbnb1

If we then stack another change that we wish to release, we bump to
4.2.2-airbnb2.

This is to prevent version conflicts with the original repo, while also
satisying bazelisk version constraints.  For example, bazelisk cannot resolve
version 4.2.2-airbnb.1

## Airbnb Release process

Put up a PR following this naming convention.  Copy and paste the text from PULL_REQUEST_TEMPLATE.md.  This is a bit of a hack, because github only automatically uses the PR template on master.

To deploy your binary to artifactory, you can use
scripts/deploy_bazel_binary.sh, which builds the binary and deploys it to
artifactory.

Note that you will need to update the VERSION in the script.

I recommend that you set the version to something like 4.2.2-test1a.  We do not
currently have delete permissions in artifactory, so I would recommend deploying
a test binary first, then testing that the build works in treehouse, before
deploying the binary to the canonical version, i.e. 4.2.2-airbnb1.

## Branch Protection

Once you are happy with your branch and have deployed the binary, go to github
settings and add branch protection to your branch, so that it does not get
deleted or edited accidentally.  We want to have the source for each deployed
binary.

# [Bazel](https://bazel.build)

*{Fast, Correct} - Choose two*

Build and test software of any size, quickly and reliably.

* **Speed up your builds and tests**:
  Bazel rebuilds only what is necessary.
  With advanced local and distributed caching, optimized dependency analysis and
  parallel execution, you get fast and incremental builds.

* **One tool, multiple languages**: Build and test Java, C++, Android, iOS, Go,
  and a wide variety of other language platforms. Bazel runs on Windows, macOS,
  and Linux.

* **Scalable**: Bazel helps you scale your organization, codebase, and
  continuous integration solution. It handles codebases of any size, in multiple
  repositories or a huge monorepo.

* **Extensible to your needs**: Easily add support for new languages and
  platforms with Bazel's familiar extension language. Share and re-use language
  rules written by the growing Bazel community.

## Getting Started

  * [Install Bazel](https://docs.bazel.build/install.html)
  * [Get started with Bazel](https://docs.bazel.build/getting-started.html)
  * Follow our tutorials:

    - [Build C++](https://docs.bazel.build/tutorial/cpp.html)
    - [Build Java](https://docs.bazel.build/tutorial/java.html)
    - [Android](https://docs.bazel.build/tutorial/android-app.html)
    - [iOS](https://docs.bazel.build/tutorial/ios-app.html)

## Documentation

  * [Bazel command line](https://docs.bazel.build/user-manual.html)
  * [Rule reference](https://docs.bazel.build/be/overview.html)
  * [Use the query command](https://docs.bazel.build/query.html)
  * [Extend Bazel](https://docs.bazel.build/skylark/concepts.html)
  * [Write tests](https://docs.bazel.build/test-encyclopedia.html)
  * [Roadmap](https://bazel.build/roadmap.html)
  * [Who is using Bazel?](https://github.com/bazelbuild/bazel/wiki/Bazel-Users)

## Contributing to Bazel

See [CONTRIBUTING.md](CONTRIBUTING.md)

[![Build status](https://badge.buildkite.com/1fd282f8ad98c3fb10758a821e5313576356709dd7d11e9618.svg?status=master)](https://ci.bazel.build)
