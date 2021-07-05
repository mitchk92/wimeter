const stm32 = @import("stm32f103.zig");
const ev = @import("EventDescriptor.zig");

fn bad_delay(count: usize) void {
    var out_count: usize = 0;
    while (out_count < count) : (out_count += 1) {
        var in_count: usize = 0;
        while (in_count < 1000) : (in_count += 1) {}
    }
}

pub const task_error = error{
    non_fatal,
    fatal,
};
pub const task_init_fn = fn () task_error!void;
pub const EventId = usize;

pub const Event = struct {
    id: EventId,
    data: event_data,
};

pub const EventType = enum {
    Packet, // a type of stream data but is a full packet of data
    Stream, // a stream of data, will be passed based on buffers and load, etc
    Block, // the full state of data, E.g. the state of 10 gpios,
};

pub const event_fn = fn (events: []Event) task_error!void;
pub const task = packed struct {
    start: task_init_fn,
    event: event_fn,
    inputs: []EventDescriptor,
    outputs: []EventDescriptor,
    config: TaskConfig,
};

pub const task_list = struct {
    num_tasks: usize,
    tasks: []*task,
};

const task_list = [_][]task{
    task{
        //        .start =

    },
};

pub fn run() void {
    for (task_list) |t, i| {}
}
