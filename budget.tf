resource "aws_budgets_budget" "monthly_cost_budget" {
  name              = "monthly-cost-budget"
  budget_type       = "COST"
  limit_amount      = "20"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  cost_filter {
    name = "Service"
    values = ["Amazon Elastic Compute Cloud - Compute"]
  }

  time_period_start = formatdate("YYYY-MM-DD", timestamp())

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"

    subscriber {
      address          = var.budget_notification_email
      subscription_type = "EMAIL"
    }
  }
}
