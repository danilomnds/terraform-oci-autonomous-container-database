# Module - Oracle Autonomous Container Database
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle Autonomous Container Database.

## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.5            | 6.8.0           |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case
```hcl
module "cdb-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-autonomous-container-database?ref=v1.0.0"
  compartment_id = <compartment id>
  db_name = <db name>
  db_version = <db version>
  patch_model = <patch_model>
  display_name = "cdb-vcp-prd-coe-001"
  autonomous_vm_cluster_id = <autonomous vm cluster id>  
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
}
output "autonomous-container-database-name" {
  value = module.cdb-<region>-<env>-<system>-<id>.display_name
}
output "autonomous-container-database-id" {
  value = module.cdb-<region>-<env>-<system>-<id>.id
}
```

## Default use case plus RBAC
```hcl
module "cdb-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-autonomous-container-database?ref=v1.0.0"
  compartment_id = <compartment id>
  db_name = <db name>
  db_version = <db version>
  patch_model = <patch_model>
  display_name = "cdb-vcp-prd-coe-001"
  autonomous_vm_cluster_id = <autonomous vm cluster id>  
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
  compartment = <compartment name>
  # GRP_OCI_APP-ENV is the Azure AD group that you are going to grant the permissions
  groups = ["OracleIdentityCloudService/GRP_OCI_APP-ENV", "group name 2"]
}
output "autonomous-container-database-name" {
  value = module.cdb-<region>-<env>-<system>-<id>.display_name
}
output "autonomous-container-database-id" {
  value = module.cdb-<region>-<env>-<system>-<id>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autonomous_vm_cluster_id | The OCID of the Autonomous VM Cluster | `string` | n/a | No |
| cloud_autonomous_vm_cluster_id | The OCID of the Cloud Autonomous VM | `string` | n/a | No |
| backup_config | Backup options for the Autonomous Container Database | `object({})` | n/a | No |
| compartment_id | the ocid of the compartment | `string` | n/a | `Yes` |
| database_software_image_id | The Autonomous Database Software Image OCID | `string` | n/a | No |
| db_name | The Database name for the Autonomous Container Database. The name must be unique within the Cloud Autonomous VM Cluster, starting with an alphabetic character, followed by 1 to 7 alphanumeric characters | `string` | n/a | No |
| db_split_threshold | The value above which an Autonomous Database will be split across multiple nodes | `string` | n/a | No |
| db_version | The base version for the Autonomous Container Database | `string` | n/a | No |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| display_name | the user-friendly name for the cloud exadata infrastructure | `string` | n/a | `Yes` |
| distribution_affinity | This option determines whether to open an Autonomous Database across the maximum number of nodes or the least number of nodes | `string` | n/a | No |
| fast_start_fail_over_lag_limit_in_seconds | The lag time for my preference based on data loss tolerance in seconds | `number` | n/a | No |
| freeform_tags | Free-form tags for this resource | `map(string)` | n/a | No |
| is_dst_file_update_enabled | Indicates if an automatic DST Time Zone file update is enabled for the Autonomous Container Database | `bool` | n/a | No |
| is_automatic_failover_enabled | Indicates whether Automatic Failover is enabled for Autonomous Container Database Dataguard Association | `bool` | n/a | No |
| key_store_id | The OCID of the key store | `string` | n/a | No |
| kms_key_id | The OCID of the key container that is used as the master encryption key in database transparent data encryption (TDE) operations | `string` | n/a | No |
| maintenance_window_details | The scheduling details for the quarterly maintenance window | `object({})` | n/a | No |
| net_services_architecture | Enabling SHARED server architecture enables a database server to allow many client processes to share very few server processes, thereby increasing the number of supported users | `string` | n/a | No |
| patch_model | Database Patch model preference | `string` | n/a | `Yes` |
| peer_cloud_autonomous_vm_cluster_id | The OCID of the peer Autonomous Cloud VM Cluster for autonomous dataguard | `string` | n/a | No |
| protection_mode | The protection mode of this Data Guard association | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | Backup options for the Autonomous Container Database | `object({})` | n/a | No |
| peer_autonomous_container_database_compartment_id | The OCID of the compartment where the standby Autonomous Container Database will be created | `string` | n/a | No |
| peer_autonomous_container_database_display_name | The display name for the peer Autonomous Container Database | `string` | n/a | No |
| peer_autonomous_vm_cluster_id | The OCID of the peer Autonomous VM cluster for Autonomous Data Guard. Required to enable Data Guard | `string` | n/a | No |
| service_level_agreement_type | The service level agreement type of the Autonomous Container Database | `string` | n/a | No |
| standby_maintenance_buffer_in_days | The scheduling detail for the quarterly maintenance window of the standby Autonomous Container Database | `string` | n/a | No |
| vault_id | The OCID of the Oracle Cloud Infrastructure vault | `string` | n/a | No |
| version_preference | The next maintenance version preference | `string` | n/a | No |
| vm_failover_reservation | The percentage of CPUs to reserve for a single node Autonomous Database, in increments of 25 | `string` | n/a | No |
| rotate_key_trigger | (Optional) (Updatable) An optional property when flipped triggers rotation of KMS key |
| groups | list of azure AD groups that will manage objects inside the bucket | `list(string)` | n/a | No |
| compartment | compartment name that will be used for policy creation | `string` | n/a | No |
| enable_group_access | enables the policy creation. If true the groups var should have a least one value | `bool` | `true` | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| backup_config | optional sub-block backup_destination_details (dbrs_policy_id) | The OCID of the DBRS policy used for backup  | `string` | n/a | No |
| backup_config | optional sub-block backup_destination_details (id) | The OCID of the backup destination  | `string` | n/a | No |
| backup_config | optional sub-block backup_destination_details (internet_proxy) | Proxy URL to connect to object store  | `string` | n/a | No |
| backup_config | optional sub-block backup_destination_details (type) | Type of the database backup destination  | `string` | n/a | No |
| backup_config | optional sub-block backup_destination_details (vpc_password) | For a RECOVERY_APPLIANCE backup destination, the password for the VPC user that is used to access the Recovery Appliance  | `string` | n/a | No |
| backup_config | optional sub-block backup_destination_details (vpc_user) | For a RECOVERY_APPLIANCE backup destination, the Virtual Private Catalog (VPC) user that is used to access the Recovery Appliance  | `string` | n/a | No |
| backup_config | recovery_window_in_days | Number of days between the current and the earliest point of recoverability covered by automatic backups | `number` | n/a | No |
| maintenance_window | custom_action_timeout_in_mins | Determines the amount of time the system will wait before the start of each database server patching operation | `number` | n/a | No |
| maintenance_window | optional sub-block days_of_week (name) | name of the day of the week  | `string` | n/a | No |
| maintenance_window | hours_of_day | The window of hours during the day when maintenance should be performed | `number` | n/a | No |
| maintenance_window | is_custom_action_timeout_enabled | If true, enables the configuration of a custom action timeout (waiting period) between database server patching operations | `bool` | n/a | No |
| maintenance_window | is_monthly_patching_enabled |  If true, enables the monthly patching option | `bool` | n/a | No |
| maintenance_window | lead_time_in_weeks | lead time window allows user to set a lead time to prepare for a down time | `number` | n/a | no |
| maintenance_window | optional sub-block months (name) | name of the month of the year  | `string` | n/a | no |
| maintenance_window | patching_mode | cloud exadata infrastructure node patching method, either "rolling" or "nonrolling" | `string` | n/a | no |
| maintenance_window | preference | the maintenance window scheduling preference | `string` | n/a | no |
| maintenance_window | skip_ru | If true, skips the release update (RU) for the quarter. You cannot skip two consecutive quarters | `bool` | n/a | no |
| maintenance_window | weeks_of_month | weeks during the month when maintenance should be performed | `number` | n/a | no |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (dbrs_policy_id) | The OCID of the DBRS policy used for backup  | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (id) | The OCID of the backup destination  | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (internet_proxy) | Proxy URL to connect to object store  | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (type) | Type of the database backup destination  | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (vpc_password) | For a RECOVERY_APPLIANCE backup destination, the password for the VPC user that is used to access the Recovery Appliance  | `string` | n/a | No |
| peer_autonomous_container_database_backup_config | optional sub-block backup_destination_details (vpc_user) | For a RECOVERY_APPLIANCE backup destination, the Virtual Private Catalog (VPC) user that is used to access the Recovery Appliance  | `string` | n/a | No |

## Output variables

| Name | Description |
|------|-------------|
| display_name | autonomous container database name|
| id | autonomous autonomous container database id |

## Documentation
Oracle Autonomous Container Database: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_autonomous_container_database](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_autonomous_container_database)