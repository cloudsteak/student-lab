provider "kubernetes" {
  config_path = "~/.kube/config"  # Update if you are using a different config location
}

variable "student_id" {
  description = "The unique ID for the student"
  type        = string
}

resource "kubernetes_namespace" "student_lab" {
  metadata {
    name = "student-${var.student_id}"
  }
}

resource "kubernetes_role" "student_access" {
  metadata {
    name      = "student-role-${var.student_id}"
    namespace = kubernetes_namespace.student_lab.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "deployments", "configmaps"]
    verbs      = ["get", "list", "create", "update", "delete"]
  }
}

resource "kubernetes_role_binding" "student_binding" {
  metadata {
    name      = "student-role-binding-${var.student_id}"
    namespace = kubernetes_namespace.student_lab.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.student_access.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = var.student_id
    api_group = "rbac.authorization.k8s.io"
  }
}
