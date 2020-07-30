resource "aws_security_group" "eks-cluster" {
  name        = "${local.cluster_name}-eks-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }


  tags = {
    Name = "terraform-eks-"
  }
}

resource "aws_security_group_rule" "eks-cluster-api" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster.id
  to_port           = 443
  type              = "ingress"
}
