# There can only be a single job definition per file. This job is named
# "example" so it will create a job with the ID and Name "example".

# The "job" stanza is the top-most configuration option in the job
# specification. A job is a declarative specification of tasks that Nomad
# should run. Jobs have a globally unique name, one or many task groups, which
# are themselves collections of one or many tasks.
#
# For more information and examples on the "job" stanza, please see
# the online documentation at:
#
#     https://www.nomadproject.io/docs/job-specification/job.html
#
job "organisation-api" {
  # The "region" parameter specifies the region in which to execute the job. If
  # omitted, this inherits the default region name of "global".
  # region = "global"

  # The "datacenters" parameter specifies the list of datacenters which should
  # be considered when placing this task. This must be provided.
  datacenters = ["west-aws"]

  # The "type" parameter controls the type of job, which impacts the scheduler's
  # decision on placement. This configuration is optional and defaults to
  # "service". For a full list of job types and their differences, please see
  # the online documentation.
  #
  # For more information, please see the online documentation at:
  #
  #     https://www.nomadproject.io/docs/jobspec/schedulers.html
  #
  type = "service"

  # The "constraint" stanza defines additional constraints for placing this job,
  # in addition to any resource or driver constraints. This stanza may be placed
  # at the "job", "group", or "task" level, and supports variable interpolation.
  #
  # For more information and examples on the "constraint" stanza, please see
  # the online documentation at:
  #
  #     https://www.nomadproject.io/docs/job-specification/constraint.html
  #
  # constraint {
  #   attribute = "${attr.kernel.name}"
  #   value     = "linux"
  # }

  # The "update" stanza specifies the job update strategy. The update strategy
  # is used to control things like rolling upgrades. If omitted, rolling
  # updates are disabled.
  #
  # For more information and examples on the "update" stanza, please see
  # the online documentation at:
  #
  #     https://www.nomadproject.io/docs/job-specification/update.html
  #
  update {
    # The "stagger" parameter specifies to do rolling updates of this job every
    # 10 seconds.
    stagger = "10s"

    # The "max_parallel" parameter specifies the maximum number of updates to
    # perform in parallel. In this case, this specifies to update a single task
    # at a time.
    max_parallel = 1
  }

  # The "group" stanza defines a series of tasks that should be co-located on
  # the same Nomad client. Any task within a group will be placed on the same
  # client.
  #
  # For more information and examples on the "group" stanza, please see
  # the online documentation at:
  #
  #     https://www.nomadproject.io/docs/job-specification/group.html
  #
  group "cache" {
    # The "count" parameter specifies the number of the task groups that should
    # be running under this group. This value must be non-negative and defaults
    # to 1.
    count = 1

    # The "restart" stanza configures a group's behavior on task failure. If
    # left unspecified, a default restart policy is used based on the job type.
    #
    # For more information and examples on the "restart" stanza, please see
    # the online documentation at:
    #
    #     https://www.nomadproject.io/docs/job-specification/restart.html
    #
    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 2
      interval = "10m"

      # The "delay" parameter specifies the duration to wait before restarting
      # a task after it has failed.
      delay = "150s"

     # The "mode" parameter controls what happens when a task has restarted
     # "attempts" times within the interval. "delay" mode delays the next
     # restart until the next interval. "fail" mode does not restart the task
     # if "attempts" has been hit within the interval.
      mode = "delay"
    }

    # The "ephemeral_disk" stanza instructs Nomad to utilize an ephemeral disk
    # instead of a hard disk requirement. Clients using this stanza should
    # not specify disk requirements in the resources stanza of the task. All
    # tasks in this group will share the same ephemeral disk.
    #
    # For more information and examples on the "ephemeral_disk" stanza, please
    # see the online documentation at:
    #
    #     https://www.nomadproject.io/docs/job-specification/ephemeral_disk.html
    #
    ephemeral_disk {
      # When sticky is true and the task group is updated, the scheduler
      # will prefer to place the updated allocation on the same node and
      # will migrate the data. This is useful for tasks that store data
      # that should persist across allocation updates.
      # sticky = true
      #
      # Setting migrate to true results in the allocation directory of a
      # sticky allocation directory to be migrated.
      # migrate = true

      # The "size" parameter specifies the size in MB of shared ephemeral disk
      # between tasks in the group.
      size = 300
    }

    # The "task" stanza creates an individual unit of work, such as a Docker
    # container, web application, or batch processing.
    #
    # For more information and examples on the "task" stanza, please see
    # the online documentation at:
    #
    #     https://www.nomadproject.io/docs/job-specification/task.html
    #
    task "organisation-api" {
      # The "driver" parameter specifies the task driver that should be used to
      # run the task.
      driver = "docker"

      env {
        SPRING_ACTIVE_PROFILES = "vagrant"
        SERVER_PORT = "8080"
        SPRING_CLOUD_CONSUL_HOST = "172.20.20.10"
        SPRING_CLOUD_VAULT_HOST = "172.20.20.12"
        SPRING_CLOUD_VAULT_SCHEME = "http"
        SPRING_CLOUD_VAULT_AUTHENTICATION = "approle"
        SPRING_CLOUD_VAULT_AUTHENTICATION = "APPROLE"
        SPRING_CLOUD_VAULT_APP_ROLE_ROLE_ID = "de701d4a-25de-914a-4a33-7075d482e8d8"
        SPRING_CLOUD_VAULT_APP_ROLE_SECRET_ID = "5a4eec94-15d8-8128-6dd1-a71e2ed7ecdf"
        SPRING_CLOUD_VAULT_MYSQL_ENABLED = "true"
        SPRING_DATASOURCE_URL = "jdbc:mysql://192.168.99.100:13306/organisation_db"
        SECURITY_OAUTH2_RESOURCE_USER_INFO_URI = "http://10.0.2.15:20016/user"
        SECURITY_OAUTH2_RESOURCE_TOKEN_INFO_URI = "http://10.0.2.15:20016/oauth/check_token"
        AUTH_SERVER_URL = "http://10.0.2.15:20016/oauth/check_token"
        SPRING_CLOUD_CONSUL_DISCOVERY_IP_ADDRESS = "$NOMAD_IP_http"
        SPRING_CLOUD_CONSUL_DISCOVERY_PREFER_IP_ADDRESS = "true"
      }
      # The "config" stanza specifies the driver configuration, which is passed
      # directly to the driver to start the task. The details of configurations
      # are specific to each driver, so please see specific driver
      # documentation for more information.
      config {
        image = "anthonyikeda/organisation-api"
        port_map {
          http = 8080
        }
        network_mode = "host"
      }

      # The "artifact" stanza instructs Nomad to download an artifact from a
      # remote source prior to starting the task. This provides a convenient
      # mechanism for downloading configuration files or data needed to run the
      # task. It is possible to specify the "artifact" stanza multiple times to
      # download multiple artifacts.
      #
      # For more information and examples on the "artifact" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/artifact.html
      #
      # artifact {
      #   source = "http://foo.com/artifact.tar.gz"
      #   options {
      #     checksum = "md5:c4aa853ad2215426eb7d70a21922e794"
      #   }
      # }

      # The "logs" stana instructs the Nomad client on how many log files and
      # the maximum size of those logs files to retain. Logging is enabled by
      # default, but the "logs" stanza allows for finer-grained control over
      # the log rotation and storage configuration.
      #
      # For more information and examples on the "logs" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/logs.html
      #
      # logs {
      #   max_files     = 10
      #   max_file_size = 15
      # }

      # The "resources" stanza describes the requirements a task needs to
      # execute. Resource requirements include memory, network, cpu, and more.
      # This ensures the task will execute on a machine that contains enough
      # resource capacity.
      #
      # For more information and examples on the "resources" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/resources.html
      #
      resources {
        cpu    = 500 # 500 MHz
        memory = 512 # 256MB
        network {
          mbits = 10
          port "http" { }
        }
      }

      # The "service" stanza instructs Nomad to register this task as a service
      # in the service discovery engine, which is currently Consul. This will
      # make the service addressable after Nomad has placed it on a host and
      # port.
      #
      # For more information and examples on the "service" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/service.html
      #
      #service {
      #  name = "organisation-api"
      #  tags = ["api", "organisation"]
      #  port = "http"
      #  check {
      #    name     = "alive"
      #    type     = "tcp"
      #    interval = "10s"
      #    timeout  = "2s"
      #  }
      #}

      # The "template" stanza instructs Nomad to manage a template, such as
      # a configuration file or script. This template can optionally pull data
      # from Consul or Vault to populate runtime configuration data.
      #
      # For more information and examples on the "template" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/template.html
      #
      # template {
      #   data          = "---\nkey: {{ key \"service/my-key\" }}"
      #   destination   = "local/file.yml"
      #   change_mode   = "signal"
      #   change_signal = "SIGHUP"
      # }

      # The "vault" stanza instructs the Nomad client to acquire a token from
      # a HashiCorp Vault server. The Nomad servers must be configured and
      # authorized to communicate with Vault. By default, Nomad will inject
      # The token into the job via an environment variable and make the token
      # available to the "template" stanza. The Nomad client handles the renewal
      # and revocation of the Vault token.
      #
      # For more information and examples on the "vault" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/vault.html
      #
      # vault {
      #   policies      = ["cdn", "frontend"]
      #   change_mode   = "signal"
      #   change_signal = "SIGHUP"
      # }

      # Controls the timeout between signalling a task it will be killed
      # and killing the task. If not set a default is used.
      # kill_timeout = "20s"
    }
  }
}
