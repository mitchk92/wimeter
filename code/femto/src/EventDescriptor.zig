pub const GPIO_Pin = struct {
    port: u8,
    pin: u8,
};

pub const Direction = enum {
    Input,
    Output,
    Bidirectional,
};

pub const GPIODescriptor = struct {
    pins: []const GPIO_pin,
    direction: Direction,
};

pub const SpiDescriptor = struct {};
pub const UsartDescriptor = struct {};
pub const I2CDescriptor = struct {};

pub const EventDescriptor = union(enum) {
    Spi: SpiDescriptor,
    I2C: I2CDescriptor,
    Usart: UsartDescriptor,
    GPIO: GPIODescriptor,
};
