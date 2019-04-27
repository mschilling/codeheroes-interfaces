workflow "Build, Test, and Publish" {
  resolves = [
    "release-it",
  ]
  on = "push"
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Build Project" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "run build"
}

action "Config Git" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Build Project"]
  args = "run config:ci"
  secrets = ["GITHUB_TOKEN"]
}

action "filter-develop" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  needs = ["Config Git"]
  args = "branch develop"
  env = {
    RELEASE_TYPE = "patch"
  }
}

action "filter-master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  needs = ["Config Git"]
  args = "branch master"
  env = {
    RELEASE_TYPE = "minor"
  }
}

action "release-it" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run release ${RELEASE_TYPE}"
  secrets = ["GITHUB_TOKEN"]
  needs = [
    "filter-master",
    "filter-develop",
  ]
}

# Filter for a new tag
