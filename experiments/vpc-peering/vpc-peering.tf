data "aws_caller_identity" "current" {}

# requester
resource "aws_vpc_peering_connection" "vpc-peering-requester" {
  vpc_id        = aws_vpc.requester-vpc.id
  peer_vpc_id   = aws_vpc.accepter-vpc.id
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_region   = "ap-southeast-2"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# accepter
resource "aws_vpc_peering_connection_accepter" "vpc-peering-accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering-requester.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}
