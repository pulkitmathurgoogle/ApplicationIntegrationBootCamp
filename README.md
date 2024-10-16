# Application Integration Workshop


## Prerequisites for workshop attendees (to be shared with customers/prospects up front):

1. This workshop DOES NOT USE QWIKLABS (as of now). Customers/Prospects will need to provision their own GCP project(s)
2. Ensure Customer GCP project has billing activated and provision [Application Integration](https://cloud.google.com/application-integration/docs/setup-application-integration) and [Integration Connectors](https://cloud.google.com/integration-connectors/docs/setup-integration-connectors). Also enable the following APIs - [Pub/Sub](https://pantheon.corp.google.com/apis/library/pubsub.googleapis.com), [Cloud Run](https://pantheon.corp.google.com/apis/library/run.googleapis.com)
3. Ensure users have required IAM roles to run the labs as follows:
   1. Application Integration Admin
   2. Cloud Functions Admin
   3. Connector Admin
   4. Logs Viewer
   5. Project IAM Admin
   6. Pub/Sub Editor
   7. Service Account Admin
   8. Service Account User
4. Install [integrationcli](https://github.com/GoogleCloudPlatform/application-integration-management-toolkit), [gcloud](https://cloud.google.com/sdk/docs/install)
5. **NOTE:** Ensure the customer has created a test connector in Integration Connectors -  This is required as the first connector created typically takes about 30 minutes to create and helps to have this created earlier before the workshop to avoid delays.
6. Clone the [repo](https://source.cloud.google.com/cloud-ce-shared-csr/application-integration-workshop/+/main:)
   1. Click the “+ Clone” button on the top right corner
   2. Follow any of the options provided - SSH Auth, gcloud SDK or Manually generated credentials