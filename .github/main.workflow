workflow "Build, Test, and Publish" {
  on = "push"
  resolves = ["Build Project"]
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

# Filter for a new tag
