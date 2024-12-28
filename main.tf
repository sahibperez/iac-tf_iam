terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 5.82.2"
      }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_group" "my_iam_group" {
  name = "terraform"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "group_attachment" {
  group      = aws_iam_group.my_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_user" "my_iam_user1" {
  name = "testgibran"
  path = "/"

  tags = {
    tag-key = "terraform"
  }
}

resource "aws_iam_access_key" "my_iam_user1" {
  user = aws_iam_user.my_iam_user1.name
}

resource "aws_iam_user" "my_iam_user2" {
  name = "testsahib"
  path = "/"

  tags = {
    tag-key = "terraform"
  }
}

resource "aws_iam_access_key" "my_iam_user2" {
  user = aws_iam_user.my_iam_user2.name
}

resource "aws_iam_user_policy_attachment" "user_attachment1" {
  user       = aws_iam_user.my_iam_user1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "user_attachment2" {
  user       = aws_iam_user.my_iam_user2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_group_membership" "group_membership" {
  name = "my-membership"
  group = aws_iam_group.my_iam_group.name
  users = [
    aws_iam_user.my_iam_user1.name,
    aws_iam_user.my_iam_user2.name,
  ]
}