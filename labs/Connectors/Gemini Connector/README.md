# Gemini/Vertex AI

In this demo, we will use the Vertex AI connector to call Gemini with a prompt.

## Pre-Requisites

Enable VertexAI in your project. Search for "Vertex AI" in the top-search bar, click on "Vertex AI" from the search results, and enable the APIs. The final result should look like the below:

![alt text](images/VertexAIAPIs.png)

Secondly, the service account you would use in the connectors must have access to vertexAI to provide authentication. Search "IAM" in the top-search bar, click on "IAM" in the search results, open th IAM home page. Identify the service account planned to be used, and click on "Edit Principal" at the right. 

![alt text](images/EditServiceAccount.png)

Search for the role "vertex AI user", add it to the principal and click "Save".

![alt text](images/EditServiceAccount2.png)


## Create Integration

1. In the Google Cloud console, go to the Application Integration page. [Go to Application Integration](https://console.cloud.google.com/integrations)
2. In the navigation menu, click Integrations. The Integrations List page appears listing all the integrations available in the Google Cloud project.
3. Create an integration called "CallGemini".

![alt text](images/CreateIntegration.png)

To configure the **VertexAI Connector**, drag and drop the vertex AI connector from the "TASKS" dropdown and click "Configure Connector".
![alt text](images/VertexAIConnector.png)


## Configure the Vertex AI Connection

To configure the Vertex AI connection, perform the following steps
1. Click "Create Connection".
![alt text](images/ConnectorCreation1.png)

2. Create the connection according to the information in the following screenshots:
   
![alt text](images/ConnectorCreation2.png)

BaseURL will be: `https://<your region>-aiplatform.googleapis.com/`
![alt text](images/ConnectorCreation3.png)
Note: The hostname is https://yourregion-aiplatform.googleapis.com/
![alt text](images/ConnectorCreation4.png)
![alt text](images/ConnectorCreation5.png)

1.  With the Connection created, let's create our integration flow

Go back to the integration, and click "Configure Connector" again. 

Choose the newly created Vertex connection
![alt text](images/ConnectorCreation6.png)

Configure the connection as per the follwoing screenshot:

![alt text](images/ConnectorCreation7.png)

Back in the integration canvas, drag and drop an API trigger and a "Data Mapping" task into the canvas, and connect them, and change the connector taskname to "InvokeGemini"

![alt text](images/IntegrationCreation1.png)

4.  Configure the Data Mapper
Open the "Data Mapping task". Create two variable as shown in the screenshots:
![alt text](images/CreateIntegration2.png)
![alt text](images/CreateIntegration4.png)
The value for the "model" variable is 
```
projects/<project_id>/locations/<region>/publishers/google/models/gemini-1.5-pro
```
In this example, we are using Gemini, however, you can choose any model deployed on Vertex AI.



Let's configure the inputs.
In the input for the first row, drag and drop the "model variable" created recently. 
In the input for the second row, concatenate the following: 
1. [{"role": "user","parts": [{"text": " (note: the string is not enclosed by quotation marks, copy and paste the exact string)
![alt text](images/Mapping1.png)

2. prompt (the variable created earlier)
![alt text](images/Mapping2.png)


3. "}]}] (note: the string is not enclosed by quotation marks, copy and paste the exact string)
![alt text](images/Mapping4.png)

4. Add the function "TO_JSON()"

![alt text](images/Mapping5.png)

Now let's configure the outputs. Drag and drop the "connectorInputPayload->Path parameterers->model" to the first row output. Drag and drop the "connectorInputPayload->RequestBody->contents" to the second row output.

![alt text](images/FinaldataMapping.png)

Exit the data mapper

## Configure the Response from Gemini

In the integration flow canvas, create a variable called "Output". It will hold the output from Gemini and return the output back to the caller of the integration
![alt text](images/CreateIntegration6.png)

To parse Gemini's response, we will use the "Data Transformer" task. 

Drag and drop a "Data Transformer" task and connect it at the end.

![alt text](images/CreateIntegration6a.png)

Open the "Data Transformer" task, click "Script" at the top-right corner, delete the existing script, and paste the following:

![alt text](images/CreateIntegration8.png)

```

// Import the additional functions library
local f = import "functions";

local geminiOutput = std.parseJson(std.extVar('`Task_1_connectorOutputPayload`')[0].ResponseBody);

{
 output: geminiOutput.candidates[0].content.parts[0].text,
}

```

The integration should look like this:

![alt text](images/FinalIntegration.png)

Click "Publish" to publish the integration

## Test the integration

Provide a prompt in the input, for example, "Is it a good idea to visit Amsterdam In the winters?"

Click "Test"


![alt text](images/Test1.png)

Gemini provides a response, which can be seen in the integration logs

![alt text](images/Test2.png)
