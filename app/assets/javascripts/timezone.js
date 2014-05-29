function set_time_zone_offset() {
    var current_time = new Date();
    $.cookie('time_zone', current_time.getTimezoneOffset());
}
if($.cookie('time_zone') == null)
{
	location.reload()
}
set_time_zone_offset();