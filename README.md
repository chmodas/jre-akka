# jre-akka
A slim Docker image that packages a custom JRE intended as the base for an Akka application with
the following dependencies:
  * Akka Cluster Sharding
  * Akka Persistence
  * Akka HTTP & gRPC
  * Kamon for instrumentation
  * Quill or Slick

The container relies on the packager to create a dedicated user.

