# OpenTelemetry in Azure Compute
Traces, logs and metrics are written to Azure Application Insights automatically when 
the environment is properly configured. 

### Functions

For Azure Functions, the Function app is provisioned with the application setting to write to the AI connection string.

### Container Instances
For Container Instances, the instance should be provisioned with the same Environment variable as above, `"APPINSIGHTS_INSTRUMENTATIONKEY" =<Value>`

### AKS
The Azure Kubernetes Service will create a config map named `app-insights-config` that can be used when declaring pods, to set the environment variable `APPINSIGHTS_INSTRUMENTATIONKEY` to `app-insights-config.connection_string`


### Java applications
See https://learn.microsoft.com/en-us/azure/azure-monitor/app/java-in-process-agent 
 - Add `-javaagent:"path/to/applicationinsights-agent-3.4.2.jar"` to JVM args
 - Add app specific logging configuration in `applicationinsights.json` :
    ```json
    {
        "role": {
            "name": "hello world"
        }
    }
    ```
