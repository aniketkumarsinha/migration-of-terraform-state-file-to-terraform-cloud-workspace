terraform {
 cloud {
  organization = "YOUR_TFC_ORGANIZATION"

  workspaces {
   name = "WORKSPACE_NAME"
  }
 }
}