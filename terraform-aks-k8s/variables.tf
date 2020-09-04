variable "agent_count" {
    default = 2
}

variable "dns_prefix" {
    default = "k8s-dev"
}

variable cluster_name {
    default = "k8s-dev"
}

variable resource_group_name {
    default = "azure-k8s-dev"
}

variable location {
    default = "West Europe"
}
