; Window
_gr_str_class      TCHAR 'CALCWIN64',0              ; class name
_gr_wc             WNDCLASSEX                       ; class
_gr_whandle        dq ?                             ; handle
_gr_dc             dq ?                             ; device context
_gr_bmi            BITMAPINFOHEADER                 ; bitmap info header
_gr_msg            MSG                              ; the message to process in the message queue
_gr_client_rect    RECT                             ; The client rect area