resource "vsphere_content_library" "library" {
  name            = var.contentLibrary.name
  storage_backing = [data.vsphere_datastore.datastore.id]
  description     = var.contentLibrary.description
}

resource "vsphere_content_library_item" "aviController" {
  count = length(var.contentLibrary.files)
  name        = basename(element(var.contentLibrary.files, count.index))
  description = basename(element(var.contentLibrary.files, count.index))
  library_id  = vsphere_content_library.library.id
  file_url = element(var.contentLibrary.files, count.index)
}