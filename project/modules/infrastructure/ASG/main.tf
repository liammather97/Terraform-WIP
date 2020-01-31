resource "aws_launch_configuration" "main" {
    image_id = "${var.ami_id}"
    instance_type = "t2.micro"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "main" {
    launch_configuration = aws_launch_configuration.main.id
    vpc_zone_identifier = [var.main_subnet_id]
    min_size = 0
    max_size = 3
}

resource "aws_autoscaling_schedule" "start" {
    scheduled_action_name = "start"
    autoscaling_group_name = "${aws_autoscaling_group.main.name}"

    min_size = 1
    max_size = 3
    desired_capacity = 3

    recurrence = var.start
}

resource "aws_autoscaling_schedule" "end" {
    scheduled_action_name = "end"
    autoscaling_group_name = "${aws_autoscaling_group.main.name}"

    min_size = 0
    max_size = 0
    desired_capacity = 0

    recurrence = var.end
}