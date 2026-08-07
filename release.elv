use ./context

var dual: = (src | context:use-dual-mod)

#
# Creates a release draft at the given Git tag, adding the given title.
#
fn create-draft { |tag title|
  dual:create-draft $tag $title
}

#
# Uploads an arbitrary number of file paths to the release identified by the given Git tag.
#
fn upload-artifacts { |&overwrite=$false release-tag @files|
  dual:upload-artifacts &overwrite=$overwrite $release-tag $@files
}