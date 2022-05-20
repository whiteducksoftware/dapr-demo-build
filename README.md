# dapr-demo-build

This repository contains deployment files for the GitHub [whiteducksoftware/dapr-demo](https://github.com/whiteducksoftware/dapr-demo) application that is part of our [talk at Microsoft Build](https://mybuild.microsoft.com/en-US/sessions/385f6cef-7d7e-4d8f-912c-cd045ad24120?source=sessions).

## Prerequisites

This demo currently only runs on a Windows machine and requires the following components:

- [Dapr](https://docs.dapr.io/getting-started/)
- [Docker](https://docs.docker.com/get-docker/)
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?WT.mc_id=AZ-MVP-5003203)

## Instructions

In this section you will learn how to run the demo in your own subscription. In the first step, you'll create an Azure resources group and add some services to it, which you'll need to run the demo.

### Specify deployment settings

Before you can deploy the environment using the Azure CLI, you need to specify the following settings inside *deploy/deploy.ps1*:

```powershell
$location = 'westeurope'

$rgName = 'rg-dapr-demo-build'
$storageAccountName = 'stodaprdemobuild'
$serviceBusName = 'sb-dapr-demo-build'
$logAnalyticsName = 'log-dapr-demo-build'
$containerAppEnvironmentName = 'conappenv-dapr-demo-build'
```

### Deploy the first components

Make sure you are logged in to Azure CLI and that you have selected the correct subscription. Execute the first 30 lines of the *deploy/deploy.ps1* script to create the resource group and some basic components including the Azure App Service environment.

### Configure dapr components

Now you will need to capture the service bus SharedAccessKey and the storage account key from the Azure portal. Then rename the *dapr/dapr-demo-secrets-store.json.rename* file to *dapr/dapr-demo-secrets-store.json* and replace the secrets with the captured values. These values are used to configure the local dapr components.

For the Azure Container App Environment dapr configuration, you also have to set the captured values inside the *deploy/pubsub.yml* and *deploy/statestore.yml* files.

### Deploy the remaining components

Now you can execute the code remaining (Line 31 and below) in the *deploy/deploy.ps1* script to deploy the dapr configurations and services to Azure. Make sure you do this inside the *deploy* directory.
