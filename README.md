<div align="center"><h1>Migration of Terraform State file from Azure Storage Account to Terraform Cloud workspace</h1></div>

## What is Terraform State file?

Terraform stores information about your infrastructure in a State file. This state file keeps track of resources created by your configuration and maps them to real-world resources.

**Migration Steps involves:**
- Download the latest State file from the Azure storage account, and rename it to `terraform.tfstate`.
- Create a new directory/folder and create a new `main.tf` file with following configurations:
```
terraform {
 cloud {
  organization = "YOUR_TFC_ORGANIZATION"

  workspaces {
   name = "WORKSPACE_NAME"
  }
 }
}
```
- Copy the downloaded state file into this new directory/folder in which you created the new `main.tf` file.
- Make sure that the local version of Terraform match with the Terraform version of your Terraform Cloud workspace. If not install the required version.
- Now run `terraform init` command. It will show you something similar:
```
Initializing Terraform Cloud...
Do you wish to proceed?
  As part of migrating to Terraform Cloud, Terraform can optionally copy your
  current workspace state to the configured Terraform Cloud workspace.

  Answer "yes" to copy the latest state snapshot to the configured
  Terraform Cloud workspace.

  Answer "no" to ignore the existing state and just activate the configured
  Terraform Cloud workspace with its existing state, if any.

  Should Terraform migrate your existing state?

  Enter a value: 
```
Type "yes".
- Now you can check over your TFC workspace and you should see the migrated state file.

**After Migration:**
- Go back to your actual directory/folder containing your Terraform infrastructure code.
- Add this same code block to your `main.tf` file or `providers.tf` file:
```
terraform {
 cloud {
  organization = "YOUR_TFC_ORGANIZATION"

  workspaces {
   name = "WORKSPACE_NAME"
  }
 }
}
```
- Run `terraform init` and `terraform plan` commands or initiate a run over Terraform Cloud. You should see that Terraform Plan phase is not showing any changes to be done.

You have successfully migrated your TF state file from storage account to TFC workspace.

### Note:
One TFC workspace can hold only a single state file. If you have multiple environments with multiple state files, you need to create a separate workspace for individual environment's state files respectively and follow the same migration steps.


