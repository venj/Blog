// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// For comment form validation.

document.observe("dom:loaded", function() {
    // Get rid of email errors
    if ($("comment_form") != null) {
        email_error = new Element("span", {class: "js_error", id: "email_js_error"}).update("cannot be blank.");
        email = $("comment_email");
        email_format_error = new Element("span", {class: "js_error", id: "email_format_error"}).update("not a valid email.");
        $("comment_email").observe("blur", function() {
            email_span = $("email_js_error");
            email_format_span = $("email_format_error");
            if ($F("comment_email").strip().blank()) {
                if (email_span == null) {
                    if (email_format_span != null) {
                        email_format_span.hide();
                    }
                    email.insert({after: email_error});
                }
                if (email_span != null && !email_span.visible()) {
                    if (email_format_span.visible()) {
                        email_format_span.hide();
                    }
                    email_span.show();
                }
            }
            else {
                if (email_span != null) {
                    $("email_js_error").hide();
                }
            }
            if ($F("comment_email").strip().gsub(/\b[-A-Za-z0-9._]+@([A-Za-z0-9.-]+\.){1,4}[A-Za-z]{2,4}\b/,'') != "") {
                if (email_format_span == null) {
                    if (email_span != null) {
                        email_span.hide();
                    }
                    email.insert({after: email_format_error});
                }
                if (email_format_span != null && !email_format_span.visible()) {
                    if (email_span.visible()) {
                        email_span.hide();
                    }
                    email_format_span.show();
                }
            }
        });

        //Deal blank name
        commenter_error = new Element("span", {class: "js_error", id: "commenter_js_error"}).update("cannot be blank.");
        commenter = $("comment_commenter");
        $("comment_commenter").observe("blur", function() {
            if ($F("comment_commenter").strip().blank()) {
                commenter_span = $("commenter_js_error");
                if (commenter_span == null) {
                    commenter.insert({after: commenter_error});
                }
                if (commenter_span != null && !commenter_span.visible()) {
                    commenter_span.show();
                }

            }
            else {
                commenter_span = $("commenter_js_error");
                if (commenter_span != null) {
                    $("commenter_js_error").hide();
                }
            }
        });

        // Deal blank content
        content_error = new Element("span", {class: "js_error", id: "content_js_error"}).update("cannot be blank.");
        content = $("comment_content");
        $("comment_content").observe("blur", function() {
            if ($F("comment_content").strip().blank()) {
                content_span = $("content_js_error");
                if (content_span == null) {
                    content.insert({after: content_error});
                }
                if (content_span != null && !content_span.visible()) {
                    content_span.show();
                }
            }
            else {
                content_span = $("content_js_error");
                if (content_span != null) {
                    $("content_js_error").hide();
                }
            }
        });

        // Deal with website format
        website = $("comment_website");
        website_format_error = new Element("span", {class: "js_error", id: "website_format_error"}).update("not a valid website.");
        $("comment_website").observe("blur", function() {
            website_format_span = $("website_format_error");
            if ($F("comment_website").strip().gsub(/\b(http(s)?:\/\/)?([A-Za-z0-9.-]+\.){1,4}[A-Za-z]{2,4}(\/.*)?/,'') != "") {
                if (website_format_span == null) {
                    website.insert({after: website_format_error});
                }
                if (website_format_span != null && !website_format_span.visible()) {
                    website_format_span.show();
                }
            }
            else if ($F("comment_website").blank() && website_format_span != null && website_format_span.visible()) {
                website_format_span.hide();
            }
            else {
                website_format_span = $("website_js_error");
                if (website_format_span != null) {
                    $("website_format_span").hide();
                }
            }
        });
    }
})