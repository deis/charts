# Deis UI

Deis UI is a third-party client-side web application that interfaces with the Deis API. It is
installed into the deis namespace and communicates using the deis-worflow service. It also
has certain annotations to "hack" itself into Deis' router as an external application.

Ensure that you've installed either the deis or deis-dev charts before installing this chart,
then go to www.$DEIS_DOMAIN in a browser to log into Deis.

Please note that this is not maintained by the Deis core development team and is missing many
features. Please report any issues and submit pull requests to https://github.com/jumbojett/deis-ui
