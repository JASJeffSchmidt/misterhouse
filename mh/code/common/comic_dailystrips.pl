
# Category = Entertainment

#@ This module downloads selected comic strips daily and
#@ cleans out old strips weekly. They can be accessed <A HREF="/comics/">here</A> 
#@ You will need to set the 'comics' parameter in your 
#@ private mh.ini. For example:
#@    comics = dilbert foxtrot userfriendly doonesbury speedbump
#@ A full list of available comics is located 
#@ in mh/web/comics/dailystrips/strips.def

$dailystrip_update = new Voice_Cmd '[Update,Clean] the daily comic strips';
$dailystrip_update-> set_info("Runs the dailystrip program to retrieve comics specified in mh.ini parm comics: $config_parms{comics}");
$dailystrip_update-> set_icon("goofy");

if ($state = said $dailystrip_update) {
    my $comics_dir = &html_alias('/comics');
    if ($state eq 'Update') {
        my $cmd = "mh -run dailystrips ";
        $cmd .= "--defs $config_parms{html_dir}/comics/dailystrips/strips.def ";
        $cmd .= "--local --basedir $comics_dir --save --nostale ";
#       $cmd .= "--titles MisterHouse --stripnav ";
        $cmd .= "--proxy $config_parms{proxy} " if $config_parms{proxy};
        $cmd .= $config_parms{comics};
        print_log "Running $cmd";
        run $cmd;
    }
    else {
        run "mh -run dailystrips-clean --dir $comics_dir 14";
    }
}

run_voice_cmd 'Update the daily comic strips' if time_now '4 am';
run_voice_cmd  'Clean the daily comic strips' if time_now '5 am';


