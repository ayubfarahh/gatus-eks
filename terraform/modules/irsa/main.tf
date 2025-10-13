data "aws_eks_cluster" "gatus-cluster" {
  name = "gatus-controlplane"
}

data "tls_certificate" "eks_cert" {
  url = data.aws_eks_cluster.gatus-cluster.identity[0].oidc[0].issuer

}

resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cert.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.gatus-cluster.identity[0].oidc[0].issuer

}

