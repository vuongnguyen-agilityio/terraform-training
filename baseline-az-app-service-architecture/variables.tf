variable "location" {
    default = "East US"
}

variable "prefix" {
    default = "storage_management"
    description = "Prefix Resource Name"
}

variable resource_group_name {
    default = "${var.prefix}-resource-group"
    description = "Resource group name"
}