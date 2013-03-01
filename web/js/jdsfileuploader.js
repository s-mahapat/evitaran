
function jdsfileuploader(_div){
    this.div = _div;
    this.url = "";
    this.filters = [{
        title : "XML files",
        extensions : "xml"
    },

    {
        title : "Excel files",
        extensions : "xls,xlsx"
    }
    ];
    this.success = null;
    this.error = null;
    this.draw = function(){
        _success = this.success;
        _error = this.error;
        $("#" + this.div).plupload({

            // General settings
            runtimes : 'html5,flash,silverlight,browserplus,gears',
            url : this.url,
            /*max_file_size : '10mb',
            chunk_size : '10mb',*/
            unique_names : false,

            // Resize images on clientside if we can
            resize : {
                width : 220,
                height : 180,
                quality : 90
            },

            // Specify what files to browse for
            filters : this.filters,

            // Flash settings
            flash_swf_url : 'js/plupload/plupload.flash.swf',

            // Silverlight settings
            silverlight_xap_url : 'js/plupload/plupload.silverlight.xap',

            // Post init events, bound after the internal events
            init : {
                FileUploaded: function(up, file, info){
                    _success(up, file, info);
                },
                Error: function(up, args) {
                    // Called when a error has occured
                    //console.log('[error] ', args);
                    _error(up, args);
                },
                FilesAdded: function(up, files){
                    // do this to allow only one file
                    if(up.files.length == 1){
                        $("#uploader_browse").addClass("ui-button-disabled");
                        $("#uploader_browse").addClass("ui-state-disabled");
                    }

                },
                FilesRemoved: function(up){
                    // do this to allow only one file
                    if(up.files.length == 0){
                        $("#uploader_browse").removeClass("ui-button-disabled");
                        $("#uploader_browse").removeClass("ui-state-disabled");
                    }
                }
            }
        });

        // Client side form validation
        $('form').submit(function(e) {
            var uploader = $('#uploader').plupload('getUploader');
            if (uploader.files.length > 1){

            }

            // Files in queue upload them first
            if (uploader.files.length > 0) {
                // When all files are uploaded submit form
                uploader.bind('StateChanged', function() {
                    if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                        $('form')[0].submit();
                    }
                });

                uploader.start();
            } else
                alert('You must at least upload one file.');

            return false;
        });
    };


}