variable "lightsail_lb_stickiness_policies" {
  description = <<EOT
Map of lightsail_lb_stickiness_policies, attributes below
Required:
    - cookie_duration
    - enabled
    - lb_name
Optional:
    - region
EOT

  type = map(object({
    cookie_duration = number
    enabled         = bool
    lb_name         = string
    region          = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.lightsail_lb_stickiness_policies : (
        (length(v.lb_name) >= 2 && length(v.lb_name) <= 255) && (can(regex("^[A-Za-z]", v.lb_name))) && (can(regex("^[0-9A-Za-z_.-]+[^_.-]$", v.lb_name)))
      )
    ])
    error_message = "all of: must be between 2 and 255 characters; must begin with an alphabetic character; must contain only alphanumeric characters, underscores, hyphens, and dots"
  }
}

