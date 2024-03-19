resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  size              = 4
  tags = {
    Name = "Data"
  }
}

#
resource "aws_volume_attachment" "ebs_att" {
  device_name  = "/dev/sdh"
  volume_id    = aws_ebs_volume.ebs.id
  instance_id  = var.instance_id
  force_detach = true
}