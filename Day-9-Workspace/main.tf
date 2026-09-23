resource "aws_vpc" "vpc-temp" {
  cidr_block = "10.0.0.0/24"
  tags       = { Name = "vpc-temp" }
}

#Terraform commands
#terraform workspace   - Shows list of global commands

#terraform workspace <subcommands>
                    # Subcommands:
                    #     delete    Delete a workspace
                    #     list      List Workspaces
                    #     new       Create a new workspace
                    #     select    Select a workspace
                    #     show      Show the name of the current workspace