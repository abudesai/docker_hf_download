Template to download a huggingface model in a Docker container during image building through wget in Dockerfile.

Our use case disallowed internet connectivity to a container after the image is built, so the model needed to be in the image.

Dockerfile uses wget to get individual files from the HF repo.
One could use git clone in Dockerfile (see commented out code in Dockerfile ) but that gets all files (i.e. pytorch, tensorflow and flax)
when only one of them is needed.
