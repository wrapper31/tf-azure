
resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}


resource "kubernetes_ingress_v1" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.nginx.metadata.0.name
    annotations = { "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true",
    "nginx.ingress.kubernetes.io/rewrite-target" = "/static/$2" }
  }
  spec {
    ingress_class_name = "nginx"
    default_backend {
      service {
        name = "nginx"
        port {
          number = 80
        }
      }
    }
    rule {
      host = var.hostname
      http {
        path {
          backend {
            service {
              name = "nginx"
              port {
                number = 80
              }
            }
          }
          path = "/static(/|$)(.*)"
        }
      }
    }
    tls {
      hosts = ["${var.hostname}"]
    }
  }
}







resource "kubernetes_manifest" "service_nginx" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "name"      = "nginx"
      "namespace" = "nginx"
    }
    "spec" = {
      "ports" = [
        {
          "port"       = 80
          "targetPort" = 80
        },
      ]
      "selector" = {
        "app" = "nginx"
      }
      "type" = "ClusterIP"
    }
  }
}

resource "kubernetes_manifest" "configmap_nginx_config" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "nginx.conf" = " events { } http { server { listen 80; location / { return 200 \"Hello world!\"; } } } "
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name"      = "nginx-config"
      "namespace" = "nginx"
    }
  }
}


resource "kubernetes_manifest" "deployment_nginx" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "nginx"
      "namespace" = "nginx"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "nginx"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "nginx"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "nginx:latest"
              "name"  = "nginx"
              "ports" = [
                {
                  "containerPort" = 80
                  "name"          = "web"
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/nginx/"
                  "name"      = "config-vol"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "items" = [
                  {
                    "key"  = "nginx.conf"
                    "path" = "nginx.conf"
                  },
                ]
                "name" = "nginx-config"
              }
              "name" = "config-vol"
            },
          ]
        }
      }
    }
  }
}
