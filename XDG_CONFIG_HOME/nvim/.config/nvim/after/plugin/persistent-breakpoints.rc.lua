local status, persistent_breakpoints = pcall(require, "persistent-breakpoints")
if (not status) then return end

persistent_breakpoints.setup({ load_breakpoints_event = { "BufReadPost" } })
