resource "aws_s3_object" "test_object" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "test.txt"
  source = "test.txt"
}
