import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "bootstrap";
import "controllers";
import "../stylesheets/application.scss";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "@hotwired/turbo-rails";
