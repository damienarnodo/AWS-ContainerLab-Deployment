# Network images

## Network Images Folder

The `network_images` folder is intended for Docker images that will be used by ContainerLab. These images should be pre-downloaded and placed in this folder before running the Ansible playbook. During the setup process, the images will be copied to the remote `/tmp` directory of the ContainerLab host and then imported into Docker.

## Naming Convention for Images

It's important to follow a specific naming convention for the images to ensure they are correctly imported into Docker. The naming convention is as follows:

`system_name_without_digit-*-tag.tar.xz`

- `system_name_without_digit`: This part of the filename should include the system name without any digits and need to be written in lower case. The system name will be converted to lowercase during the import process.
- `*`: This is a wildcard segment that can include any characters but should not contain the version or tag information.
- `tag`: This part should specify the version or tag of the image. The tag can include both lowercase and uppercase characters and digits.

### Example

Given an image file named `cEOS64-lab-4.30.3M.tar.xz`:

- `cEOS64` will be the system name. Digits will be removed `ceos`.
- `4.30.3M` will be the tag, kept as-is.

The image will be imported into Docker with the tag `ceos:4.30.3M`.

Please ensure that all image files in the `network_images` folder conform to this naming convention for the automated process to function correctly.

Arista cEOS image can be downlaoded at : arista.com  
`ceos-lab-4.30.3M.tar.xz`
