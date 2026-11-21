function attempt_to_unlock_achievement(arg0)
{
    // Achievements are not supported by this Archipelago build and are sent to a platform
    // debug mode reports them instead for now until rewritten as ap checks
    if (global.debug == true)
        show_debug_message("debug: unlocked: " + arg0);
}
