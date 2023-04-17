// rhai script to deterministically get the information about the project

// Set the project name
let project_name = variable::prompt("What is the name of the project?");
variable::set("project-name", project_name);

// Set the project description
let project_description = variable::prompt("What is the description of the project?", "A simple rust-based CLI Project");
variable::set("project-description", project_description);

// Set the github username
let username = variable::prompt("What is your Github username?", "AliSajid");
variable::set("gh_user", username);

// Set the project license
let license = variable::prompt("Select license?", "Dual MIT/Apache-2.0", ["MIT", "Apache-2.0", "GPL-3.0", "Dual MIT/Apache-2.0", "None"]);

switch license {
  "MIT" => {
    file::delete("LICENSE-APACHE");
    file::delete("LICENSE-GPL-3.0-OR-LATER");
    file::rename("LICENSE-MIT", "LICENSE");
  }
  "Apache-2.0" => {
    file::delete("LICENSE-MIT");
    file::delete("LICENSE-GPL-3.0-OR-LATER");
    file::rename("LICENSE-APACHE", "LICENSE");
  }
  "GPL-3.0" => {
    file::delete("LICENSE-MIT");
    file::delete("LICENSE-APACHE");
    file::rename("LICENSE-GPL-3.0-OR-LATER", "LICENSE");
  }
  "Dual MIT/Apache-2.0" => {
    file::delete("LICENSE-GPL-3.0-OR-LATER");
  }
  "None" => {
    file::delete("LICENSE-MIT");
    file::delete("LICENSE-APACHE");
    file::delete("LICENSE-GPL-3.0-OR-LATER");
    file::delete("meta/LICENSE-HEADER.liquid");
  }
}
variable::set("license", license);

// Set the project minimum supported rust version (MSRV)
let msrv = variable::prompt("What is the minimum supported rust version (MSRV)?", "1.64.0");
variable::set("msrv", msrv);

// Set the project update gist
let dynamic_badge_gist = variable::prompt("What is the gist id for the dynamic badge workflow?");
variable::set("dynamic-badge-gist", dynamic_badge_gist);

// Include a security email?
let include_security_email = variable::prompt("Include a security email?", false);
variable::set("include_security_email", include_security_email);
if include_security_email {
    let security_email = variable::prompt("What is the security email?");
    variable::set("security_email", security_email);
}
