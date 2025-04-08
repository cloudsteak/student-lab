data "azurerm_subscription" "current" {}


resource "azurerm_policy_definition" "tanulo_region" {
  name         = "limit-region-for-tanulo-users"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Csak az alábbi régó használható: Sweden Central, North Europe, Poland Central"
  description  = "Csak kijelölt régiók használata engedélyezett"
  policy_rule  = file("../files/specific-regions-only-policy-definition.json")
}

resource "azurerm_subscription_policy_assignment" "tanulo_region_assignment" {
  name                 = "limit-region-for-sweden-only"
  policy_definition_id = azurerm_policy_definition.tanulo_region.id
  subscription_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  display_name         = "Csak Sweden Central, North Europe, Poland Central régiók használhatók!"
  description          = "Csak az alábbi régó használható: Sweden Central, North Europe, Poland Central"
  timeouts {
    create = "60m"
    delete = "60m"
  }
}



