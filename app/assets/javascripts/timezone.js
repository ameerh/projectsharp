function set_time_zone_offset() {
    var current_time = new Date();
    $.cookie('time_zone', current_time.getTimezoneOffset());
}
set_time_zone_offset();