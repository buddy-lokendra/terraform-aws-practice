variable "db_engine" {
  description = "RDS database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "RDS MySQL engine version"
  type        = string
  default     = "8.0"
}
