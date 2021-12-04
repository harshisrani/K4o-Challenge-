# Create Mongodbatlas Cluster
resource "mongodbatlas_cluster" "animals-mongo" {
  project_id = var.mongdbatlas_project_id
  name = "${var.atlas_project_name}-${var.environment}-cluster"
  num_shards = 1
  replication_factor = 3
  provider_backup_enabled = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version = "4.2"
  
  provider_name = "GCP"
  disk_size_gb = 40
  provider_instance_size_name = var.cluster_instance_size_name
  provider_region_name = var.atlas_region
}

connection_strings = {
    for svc in var.service_configuration :
    mongodb+srv://svc.serviceName.:random_password.db-user-password@[svc.mongoCluster]/[svc.mongoDatabase]/[svc.mongoCollection]
  }
}

# Create a Database Password
resource "random_password" "db-user-password" {
  length = 15
  special = true
  override_special = "$%@"
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  username = var.username
  password = random_password.db-user-password.result
  project_id = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"
  roles {
    role_name     = "read"
    database_name = "${var.atlas_project_name}-db"
  }
}
