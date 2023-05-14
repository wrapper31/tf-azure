resource "kubernetes_namespace" "instrumentation" {
  metadata {
    name = "instrumentation"
  }
}

resource "kubernetes_secret" "app_insights_config" {
  count = var.app_insights_connection_string != null ? 1 : 0

  metadata {
    namespace = kubernetes_namespace.instrumentation.id
    name      = "app-insights-config"
  }

  data = {
    connection_string = var.app_insights_connection_string
  }
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}
