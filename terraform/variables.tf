## Azure config variables ##
variable "client_id" {
    default = ""
}

variable "client_secret" {
    default = ""
}

variable location {
  default = "Central US"
}

## Resource group variables ##
variable resource_group_name {
  default = "oladaksdemo"
}


## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "aksdemo1"
}

variable "agent_count" {
  default = 3
}

variable "dns_prefix" {
  default = "aksdemo"
}

variable "admin_username" {
    default = "demo"
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}
