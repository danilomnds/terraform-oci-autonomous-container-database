resource "oci_database_autonomous_container_database" "autonomous_container_database" {
  autonomous_vm_cluster_id = var.autonomous_vm_cluster_id
  cloud_autonomous_vm_cluster_id = var.cloud_autonomous_vm_cluster_id
  dynamic "backup_config" {
    for_each = var.backup_config != null ? [var.backup_config] : []
    content {
      dynamic "backup_destination_details" {
        for_each = backup_config.value.backup_destination_details != null ? [backup_config.value.backup_destination_details] : []
        content {
          #dbrs_policy_id = lookup(backup_destination_details.value, "dbrs_policy_id", null)
          id = lookup(backup_destination_details.value, "id", null)
          internet_proxy = lookup(backup_destination_details.value, "internet_proxy", null)
          type = lookup(backup_destination_details.value, "type", null)
          vpc_password = lookup(backup_destination_details.value, "vpc_password", null)
          vpc_user = lookup(backup_destination_details.value, "vpc_user", null)
        }        
      }
      recovery_window_in_days = lookup(backup_config.value, "recovery_window_in_days", null)        
    }    
  }
  compartment_id                      = var.compartment_id
  database_software_image_id = var.database_software_image_id
  db_name = var.db_name
  db_split_threshold = var.db_split_threshold
  db_version = var.db_version  
  defined_tags                        = local.defined_tags
  display_name                        = var.display_name
  distribution_affinity = var.distribution_affinity
  fast_start_fail_over_lag_limit_in_seconds = var.fast_start_fail_over_lag_limit_in_seconds
  freeform_tags                       = var.freeform_tags
  is_dst_file_update_enabled = var.is_dst_file_update_enabled
  is_automatic_failover_enabled = var.is_automatic_failover_enabled
  key_store_id = var.key_store_id
  kms_key_id = var.kms_key_id
  dynamic "maintenance_window_details" {
    for_each = var.maintenance_window_details != null ? [var.maintenance_window_details] : []
    content {
      custom_action_timeout_in_mins = lookup(maintenance_window_details.value, "custom_action_timeout_in_mins", null)
      dynamic "days_of_week" {
        for_each = maintenance_window_details.value.days_of_week != null ? [maintenance_window_details.value.days_of_week] : []
        content {
          name = days_of_week.value.name
        }        
      }
      hours_of_day = lookup(maintenance_window_details.value, "hours_of_day", null)
      is_custom_action_timeout_enabled = lookup(maintenance_window_details.value, "is_custom_action_timeout_enabled", null)
      is_monthly_patching_enabled = lookup(maintenance_window_details.value, "is_monthly_patching_enabled", null)
      lead_time_in_weeks = lookup(maintenance_window_details.value, "lead_time_in_weeks", null)
      dynamic "months" {
        for_each = maintenance_window_details.value.months != null ? [maintenance_window_details.value.months] : []
        content {
          name = months.value.name
        }        
      }
      patching_mode = lookup(maintenance_window_details.value, "patching_mode", null)
      preference = lookup(maintenance_window_details.value, "preference", null)
      skip_ru = lookup(maintenance_window_details.value, "skip_ru", null)
      weeks_of_month = lookup(maintenance_window_details.value, "weeks_of_month", null)
    }
  }
  net_services_architecture = var.net_services_architecture
  patch_model = var.patch_model
  peer_cloud_autonomous_vm_cluster_id = var.peer_cloud_autonomous_vm_cluster_id 
  protection_mode = var.protection_mode
  dynamic "peer_autonomous_container_database_backup_config" {
    for_each = var.peer_autonomous_container_database_backup_config != null ? [var.peer_autonomous_container_database_backup_config] : []
    content {
      dynamic "backup_destination_details" {
        for_each = peer_autonomous_container_database_backup_config.value.backup_destination_details != null ? [peer_autonomous_container_database_backup_config.value.backup_destination_details] : []
        content {
          #dbrs_policy_id = lookup(backup_destination_details.value, "dbrs_policy_id", null)
          id = lookup(backup_destination_details.value, "id", null)
          internet_proxy = lookup(backup_destination_details.value, "internet_proxy", null)
          type = lookup(backup_destination_details.value, "type", null)
          vpc_password = lookup(backup_destination_details.value, "vpc_password", null)
          vpc_user = lookup(backup_destination_details.value, "vpc_user", null)
        }        
      }
      recovery_window_in_days = lookup(peer_autonomous_container_database_backup_config.value, "recovery_window_in_days", null)        
    }
  }
  peer_autonomous_container_database_compartment_id = var.peer_autonomous_container_database_compartment_id
  peer_autonomous_container_database_display_name = var.peer_autonomous_container_database_display_name
  peer_autonomous_vm_cluster_id = var.peer_autonomous_vm_cluster_id  
  service_level_agreement_type  = var.service_level_agreement_type 
  standby_maintenance_buffer_in_days = var.standby_maintenance_buffer_in_days
  vault_id = var.vault_id
  version_preference = var.version_preference
  vm_failover_reservation = var.vm_failover_reservation
  rotate_key_trigger = var.rotate_key_trigger
  lifecycle {
    ignore_changes = [
      # due to a bug on database_edition parameter it was added on ignore_changes
      defined_tags["IT.create_date"], database_edition
    ]
  }
  timeouts {
    create = "12h"
    delete = "6h"
  }
}

resource "oci_identity_policy" "autonomous_container_database_policy" {
  #if you are deploying the resource outside your home region uncomment the line below
  #provider   = oci.oci-gru
  depends_on = [oci_database_autonomous_container_database.autonomous_container_database]
  for_each = {
    for group in var.groups : group => group
    if var.groups != [] && var.compartment != null
  }
  compartment_id = var.compartment_id
  name           = "policy_${var.display_name}"
  description    = "allow one or more groups to read the autonomous container database"
  statements = [
    "Allow group ${each.value} to read autonomous-container-databases in compartment ${var.compartment}"
  ]
}