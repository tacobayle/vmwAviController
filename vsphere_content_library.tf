resource "vsphere_content_library" "library" {
  name            = var.contentLibrary.name
  storage_backing = [data.vsphere_datastore.datastore.id]
  description     = var.contentLibrary.description
}

resource "vsphere_content_library_item" "aviController" {
  name        = basename(var.contentLibrary.file)
  description = basename(var.contentLibrary.file)
  library_id  = vsphere_content_library.library.id
  file_url = var.contentLibrary.file
}