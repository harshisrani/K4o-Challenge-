#Project id
variable "mongdbatlas_project_id" {
  type        = string
  description = "Project id for cluster"
  default     = "007"
}

variable "atlas_project_name" {
  type        = string
  description = "Project name for cluster"
  default     = "Zooming"
}

variable "environment" {
  type        = string
  description = "The environment to be built"
  default     = "dev"
}

#Cluster instance size name 
variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
  default     = "M10"
}

#Atlas region
variable "atlas_region" {
  type        = string
  description = "GCP region where resources will be created"
  default     = "WESTERN_EUROPE"
}

#Usernames
variable "username" {
  description = "username"
  type        = list(string)
  default     = ["possums-data-store","numbats-data-store","marsupial-data-store"]
}

# service configuration
service_configuration = [
  {
    serviceName     = "possums-data-store"
    mongoCluster    = "animals-mongo"
    mongoDatabase   = "marsupials-dev"
    mongoCollection = ["possums"]
  },
  {
    serviceName     = "numbats-data-store"
    mongoCluster    = "animals-mongo"
    mongoDatabase   = "marsupials-dev"
    mongoCollection = ["numbats"]
  },
   {
    serviceName     = "marsupial-data-store"
    mongoCluster    = "animals-mongo"
    mongoDatabase   = "marsupials-prod"
    mongoCollection = ["numbats","possums"]
  },
] 
