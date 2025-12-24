"use strict";
// Class definition

var KTSummernoteDemo = function () {
    // Private functions
    var demos = function () {
        $('.summernote').summernote({
            lang: 'tr-TR',
            height: 400,
            tabsize: 2,
            icons: {
                cleaner: "la la-facebook"
            },
            toolbar: [
                ['view', ['fullscreen', 'codeview']],
                ['cleaner', ['cleaner']], // The Button
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['table', ['table']],
                ['insert', ['picture', 'media', 'link', 'hr']],
                ['help', ['help']]
            ],
            cleaner: {
                action: 'button',
                newline: '<br>',
                icon: '<i class="note-icon-trash"></i>',
                keepHtml: false,
                keepClasses: false,
                badTags: ['applet', 'body', 'col', 'colgroup', 'embed', 'html', 'noframes', 'noscript', 'script', 'style', 'title'],
                badAttributes: ['bgcolor', 'border', 'height', 'cellpadding', 'cellspacing', 'lang', 'start', 'style', 'valign', 'width'],
                limitChars: false,
                limitDisplay: 'both',
                limitStop: false
            },
            callbacks: {
                onImageUpload: function (files, editor, welEditable) {
                    sendFile(files[0], editor, welEditable);
                }
            }
        });
    }

    return {
        // public functions
        init: function () {
            demos();
        }
    };
}();

// Initialization
jQuery(document).ready(function () {
    KTSummernoteDemo.init();
});