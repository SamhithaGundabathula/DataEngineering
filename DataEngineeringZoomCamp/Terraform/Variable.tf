variable "location" {
  description = "project location"
  default     = "US"

}
variable "bq_dataset_name" {
  description = "My BG datasename"
  default     = "demo_dataset"

}

variable "gcs_bucket_name" {
  description = "My storage bucket name"
  default     = "terraformpractisebucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}