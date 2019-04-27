workflow "Build, Test, and Publish" {
  on = "push"
  resolves = [
    "Build lib",
    "Config Git",
  ]
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

action "Build lib" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run release"
  secrets = ["GITHUB_TOKEN"]
  needs = ["Config Git"]
} # Filter for a new tag
