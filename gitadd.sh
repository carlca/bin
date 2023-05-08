    #!/bin/zsh

    # update/add files recursively
    git add -A .

    # commit with user supplied message
    git commit -m "$1"

    # the final push!
    git push
