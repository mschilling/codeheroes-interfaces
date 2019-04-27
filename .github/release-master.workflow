workflow "Build, Test, and Publish" {
  resolves = [
    "release-it",
  ]
  on = "push"
}

action "filter-master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
  env = {
    RELEASE_TYPE = "minor"
  }
}

action "Build" {
  needs = ["filter-master"]
  uses = "actions/npm@master"
  args = "install"
}

action "Build Project" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "run build"
}

action "git-config" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Build Project"]
  args = "run config:ci"
  secrets = ["GITHUB_TOKEN"]
}

action "release-it" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run release minor"
  secrets = ["GITHUB_TOKEN"]
  needs = [
    "git-config",
  ]
}
