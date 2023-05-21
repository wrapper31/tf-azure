
resource "kubernetes_namespace" "ucptest" {
  metadata {
    name = "ucptestapp"
  }
}


resource "kubernetes_ingress_v1" "ucptest" {
  metadata {
    name      = "ucptestapp"
    namespace = kubernetes_namespace.ucptest.metadata.0.name
    annotations = { "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true",
    "nginx.ingress.kubernetes.io/rewrite-target" = "/static/$2" }
  }
  spec {
    ingress_class_name = "nginx"
    default_backend {
      service {
        name = "ucptestapp"
        port {
          number = 8080
        }
      }
    }
    rule {
      host = var.hostname
      http {
        path {
          backend {
            service {
              name = "ucptestapp"
              port {
                number = 8080
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

resource "kubernetes_deployment_v1" "ucptest" {
  metadata {
    name      = "ucptestapp"
    namespace = kubernetes_namespace.ucptest.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ucptestapp"
      }
    }
    template {
      metadata {
        labels = {
          app = "ucptestapp"
        }
      }
      spec {
        container {
          image = "a210298pkmusea2crmain.azurecr.io/istio/examples-helloworld-v1"
          name  = "mytestapp-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}




resource "kubernetes_service_v1" "ucptest" {
  metadata {
    name      = "ucptestapp"
    namespace = kubernetes_namespace.ucptest.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.ucptest.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 80
    }
  }

}
