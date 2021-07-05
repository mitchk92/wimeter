const configType = enum {
    Int,
    Float,
    Char,
};

const ConfigItem = struct {
    offset: usize,
    num_elems: usize,
    val_type: configType,
};

pub const TaskConfig = struct {
    pub fn init(time: comptime type) TaskConfig {}
};
