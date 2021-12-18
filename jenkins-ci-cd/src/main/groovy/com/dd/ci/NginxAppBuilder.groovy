package com.dd.ci

import javaposse.jobdsl.dsl.DslFactory
import javaposse.jobdsl.dsl.Job

class NginxAppBuilder {

    DslFactory dslFactory
    String jobName
    String description
    String displayName
    String githubUrl
    String branchesName
    String credentialId
    String environment
    String emailId

    Job build() {
        dslFactory.pipelineJob(jobName) {
            description(description)
            displayName(displayName)

            definition {
                cpsScm {
                    scm {
                        git {
                            branch(branchesName)
                            remote {
                                url(githubUrl)
                                credentials(credentialId)
                            }
                        }
                        scriptPath('jenkins/nginx-app/Jenkinsfile')
                        lightweight(true)
                    }
                }
            }
            parameters {

            }
        }
    }
}
