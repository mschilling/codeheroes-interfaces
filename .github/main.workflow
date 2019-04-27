workflow "Build, Test, and Publish (master)" {
  resolves = [
    "release-it-master",
  ]
  on = "push"
}

action "filter-master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
}

action "prepare-master" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["filter-master"]
  args = "run config:ci"
}

action "build-master" {
  needs = ["prepare-master"]
  uses = "actions/npm@master"
  args = "install"
}

action "release-master" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run release minor"
  secrets = ["GITHUB_TOKEN"]
  needs = ["build-master"]
}

workflow "Build, Test, and Publish (develop)" {
  resolves = [
    "release-develop",
  ]
  on = "push"
}

action "filter-develop" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch develop"
}

action "prepare-develop" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["filter-develop"]
  args = "run config:ci"
}

action "build-develop" {
  needs = ["prepare-develop"]
  uses = "actions/npm@master"
  args = "install"
}

action "release-develop" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run release patch"
  secrets = ["GITHUB_TOKEN"]
  needs = ["build-develop"]
}
