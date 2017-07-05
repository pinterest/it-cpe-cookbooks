# IT-CPE-Cookbooks
The IT-CPE-Cookbooks ("Client Platform Engineering") repo contains a suite of cookbooks that we use to manage our fleet client devices

## Notes
In order to use most of these cookbooks, you must also deploy some of Facebook's cookbooks found [here](https://github.com/facebook/IT-CPE/tree/master/chef)

The following cookbooks will more than likely be required:
- cpe_init
- cpe_launchd
- cpe_profiles
- cpe_utils

The following cookbooks are also ecommended for dynamic configurations:
- cpe_node_customizations
- cpe_user_customizations
