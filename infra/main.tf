provider "aws" {
    region = "us-west-2"
}

resource "aws_api_gateway_rest_api" "nutrition_information_api" {
  name = "Nutrition.Information.Api"
  description = "This is an API to retrieve nutritional information about a given item of food."
}

resource "aws_api_gateway_resource" "nutrition_information_api_v1" {
  rest_api_id = "${aws_api_gateway_rest_api.nutrition_information_api.id}"
  parent_id = "${aws_api_gateway_rest_api.nutrition_information_api.root_resource_id}"
  path_part = "v1"
}

resource "aws_api_gateway_resource" "nutrition_information_api_v1_ping" {
  rest_api_id = "${aws_api_gateway_rest_api.nutrition_information_api.id}"
  parent_id = "${aws_api_gateway_resource.nutrition_information_api_v1.id}"
  path_part = "ping"
}

resource "aws_api_gateway_method" "nutrition_information_api_v1_ping_method" {
  rest_api_id = "${aws_api_gateway_rest_api.nutrition_information_api.id}"
  resource_id = "${aws_api_gateway_resource.nutrition_information_api_v1_ping.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "nutrition_information_api_v1_ping_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.nutrition_information_api.id}"
  resource_id = "${aws_api_gateway_resource.nutrition_information_api_v1_ping.id}"
  http_method = "${aws_api_gateway_method.nutrition_information_api_v1_ping_method.http_method}"
  type = "MOCK"
  request_templates {
    "application/json" = <<EOF
    {
      "statusCode": 200
    }
    EOF
  }
}

resource "aws_api_gateway_deployment" "nutrition_information_api_deployment" {
  depends_on = ["aws_api_gateway_method.nutrition_information_api_v1_ping_method", "aws_api_gateway_integration.nutrition_information_api_v1_ping_integration"]
  rest_api_id = "${aws_api_gateway_rest_api.nutrition_information_api.id}"
  stage_name = "default"
}

output "nutrition_information_api_uri" {
    value = "https://${aws_api_gateway_rest_api.nutrition_information_api.id}.execute-api.us-west-2.amazonaws.com"
}