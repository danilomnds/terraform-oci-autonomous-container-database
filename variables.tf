variable "autonomous_vm_cluster_id" {
  type = string
  default = null  
}

variable "cloud_autonomous_vm_cluster_id" {
  type = string
  default = null  
}

variable "backup_config" {
  type = object({
    backup_destination_details = optional(object({
      dbrs_policy_id = optional(string)
      id = optional(string)
      internet_proxy = optional(string)
      type = optional(string)
      vpc_password = optional(string)
      vpc_user = optional(string)
    }))
    recovery_window_in_days = optional(number)
  })
  default = null
}

variable "compartment_id" {
  type = string
}

variable "database_software_image_id" {
  type = string
  default = null  
}

variable "db_name" {
  type = string
  default = null  
}

variable "db_split_threshold" {
  type = number
  default = null  
}

variable "db_version" {
  type = string
  default = null  
}

variable "defined_tags" {
  type    = map(string)
  default = null
}

variable "display_name" {
  type = string
}

variable "distribution_affinity" {
  type = string
  default = null  
}

variable "fast_start_fail_over_lag_limit_in_seconds" {
  type = number
  default = null  
}

variable "freeform_tags" {
  type    = map(string)
  default = null
}

variable "is_dst_file_update_enabled" {
  type = bool
  default = null  
}

variable "is_automatic_failover_enabled" {
  type = bool
  default = null  
}

variable "key_store_id" {
  type = string
  default = null  
}

variable "kms_key_id" {
  type = string
  default = null  
}

variable "maintenance_window_details" {
  type = object({
    custom_action_timeout_in_mins = optional(number)
    days_of_week = optional(object({
      name = string
    }))
    hours_of_day       = optional(number)
    is_custom_action_timeout_enabled = optional(bool)
    is_monthly_patching_enabled = optional(bool)
    lead_time_in_weeks = optional(number)
    months = optional(object({
      name = string
    }))
    patching_mode  = optional(string)
    preference     = optional(string)
    skip_ru = optional(bool)
    weeks_of_month = optional(string)
  })
  default = null
}

variable "net_services_architecture" {
  type = string
  default = null  
}

variable "patch_model" {
  type = string  
}

variable "peer_cloud_autonomous_vm_cluster_id" {
  type = string
  default = null  
}

variable "protection_mode" {
  type = string
  default = null  
}

variable "peer_autonomous_container_database_backup_config" {
  type = object({
    backup_destination_details = optional(object({
      dbrs_policy_id = optional(string)
      id = optional(string)
      internet_proxy = optional(string)
      type = optional(string)
      vpc_password = optional(string)
      vpc_user = optional(string)
    }))
    recovery_window_in_days = optional(number)
  })
  default = null
}

variable "peer_autonomous_container_database_compartment_id" {
  type = string
  default = null  
}

variable "peer_autonomous_container_database_display_name" {
  type = string
  default = null  
}

variable "peer_autonomous_vm_cluster_id" {
  type = string
  default = null  
}

variable "service_level_agreement_type" {
  type = string
  default = null  
}

variable "standby_maintenance_buffer_in_days" {
  type = number
  default = null
}

variable "vault_id" {
  type = string
  default = null  
}

variable "version_preference" {
  type = string
  default = null  
}

variable "vm_failover_reservation" {
  type = string
  default = null  
}

variable "rotate_key_trigger" {
  type = string
  default = null  
}

variable "groups" {
  type    = list(string)
  default = []
}

variable "compartment" {
  type    = string
  default = null
}