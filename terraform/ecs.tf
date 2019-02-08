data "aws_ecs_task_definition" "courtbot" {
  task_definition = "${aws_ecs_task_definition.courtbot.family}"
}

resource "aws_ecs_cluster" "courtbot" {
  name = "courtbot"
}

resource "aws_ecs_task_definition" "courtbot" {
  family = "courtbot"
  container_definitions = <<DEFINITION
[
  {
    "environment": [
      {
        "name": "MIX_ENV",
        "value": "prod"
      },
      {
        "name": "",
        "value": "TODO"
      }
    ],
    "essential": true,
    "image": "codeforboise/courtbot:latest",
    "name": "courtbot"
  }
]
DEFINITION
}

resource "aws_ecs_service" "courtbot" {
  name            = "courtbot"
  cluster         = "${aws_ecs_cluster.courtbot.id}"
  task_definition = "${aws_ecs_task_definition.courtbot.arn}"
  launch_type     = "fargate"
  desired_count   = 1
  depends_on = [
    "aws_ecs_task_definition.courtbot"
  ]
}
