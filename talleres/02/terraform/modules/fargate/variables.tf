variable "name" {
  type        = string
  description = "nombre de la aplicación"
}
variable "service_port" {
}
variable "service_cpu" {
}
variable "service_memory" {
}
variable "app_image" {
}
variable "fargate_cpu" {
}
variable "fargate_memory" {
}
variable "app_port" {
}

variable "environment_variables" {}
variable "ecs_cluster_arn" {}
variable "service_scale_desired" {}
variable "service_scale_max" {}
variable "service_scale_min" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "target_group_arn" {}
variable "security_group_id" {}
variable "service_metrics_cpu_utilization_high_threshold" {}
variable "service_metrics_cpu_utilization_low_threshold" {}
variable "service_metrics_memory_utilization_high_threshold" {}
variable "service_metrics_memory_utilization_low_threshold" {}
