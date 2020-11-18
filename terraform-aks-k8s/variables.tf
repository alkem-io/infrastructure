variable "agent_count" {
    default = 2
}

variable "dns_prefix" {
    default = "k8s-test"
}

variable cluster_name {
    default = "k8s-test"
}

variable resource_group_name {
    default = "azure-k8s-test"
}

variable location {
    default = "West Europe"
}
