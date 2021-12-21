// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

global.toastr = require("toastr")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application"

require("packs/material-dashboard.js")
require("packs/material-dashboard.js.map")
require("packs/material-dashboard.min.js")

require("packs/core/bootstrap.bundle.min.js")
require("packs/core/bootstrap.min.js")
require("packs/core/popper.min.js")

require("packs/plugins/bootstrap-notify.js")
require("packs/plugins/Chart.extension.js")
require("packs/plugins/chartjs.min.js")
require("packs/plugins/perfect-scrollbar.min.js")
require("packs/plugins/smooth-scrollbar.min.js")
require("packs/plugins/world.js")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
