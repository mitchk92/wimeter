const pinmap = @import("pin.zig");

const A0 = pinmap.pin{ .port = 0, .pin = 0 };
const A1 = pinmap.pin{ .port = 0, .pin = 1 };
const A2 = pinmap.pin{ .port = 0, .pin = 2 };
const A3 = pinmap.pin{ .port = 0, .pin = 3 };
const A4 = pinmap.pin{ .port = 0, .pin = 4 };
const A5 = pinmap.pin{ .port = 0, .pin = 5 };
const A6 = pinmap.pin{ .port = 0, .pin = 6 };
const A7 = pinmap.pin{ .port = 0, .pin = 7 };

const B0 = pinmap.pin{ .port = 1, .pin = 0 };
const B1 = pinmap.pin{ .port = 1, .pin = 1 };
const B2 = pinmap.pin{ .port = 1, .pin = 2 };
const B3 = pinmap.pin{ .port = 1, .pin = 3 };
const B4 = pinmap.pin{ .port = 1, .pin = 4 };
const B5 = pinmap.pin{ .port = 1, .pin = 5 };
const B6 = pinmap.pin{ .port = 1, .pin = 6 };
const B7 = pinmap.pin{ .port = 1, .pin = 7 };

const C0 = pinmap.pin{ .port = 2, .pin = 0 };
const C1 = pinmap.pin{ .port = 2, .pin = 1 };
const C2 = pinmap.pin{ .port = 2, .pin = 2 };
const C3 = pinmap.pin{ .port = 2, .pin = 3 };
const C4 = pinmap.pin{ .port = 2, .pin = 4 };
const C5 = pinmap.pin{ .port = 2, .pin = 5 };
const C6 = pinmap.pin{ .port = 2, .pin = 6 };
const C7 = pinmap.pin{ .port = 2, .pin = 7 };

const D0 = pinmap.pin{ .port = 3, .pin = 0 };
const D1 = pinmap.pin{ .port = 3, .pin = 1 };
const D2 = pinmap.pin{ .port = 3, .pin = 2 };
const D3 = pinmap.pin{ .port = 3, .pin = 3 };
const D4 = pinmap.pin{ .port = 3, .pin = 4 };
const D5 = pinmap.pin{ .port = 3, .pin = 5 };
const D6 = pinmap.pin{ .port = 3, .pin = 6 };
const D7 = pinmap.pin{ .port = 3, .pin = 7 };

const E0 = pinmap.pin{ .port = 4, .pin = 0 };
const E1 = pinmap.pin{ .port = 4, .pin = 1 };
const E2 = pinmap.pin{ .port = 4, .pin = 2 };
const E3 = pinmap.pin{ .port = 4, .pin = 3 };
const E4 = pinmap.pin{ .port = 4, .pin = 4 };
const E5 = pinmap.pin{ .port = 4, .pin = 5 };
const E6 = pinmap.pin{ .port = 4, .pin = 6 };
const E7 = pinmap.pin{ .port = 4, .pin = 7 };

const F0 = pinmap.pin{ .port = 5, .pin = 0 };
const F1 = pinmap.pin{ .port = 5, .pin = 1 };
const F2 = pinmap.pin{ .port = 5, .pin = 2 };
const F3 = pinmap.pin{ .port = 5, .pin = 3 };
const F4 = pinmap.pin{ .port = 5, .pin = 4 };
const F5 = pinmap.pin{ .port = 5, .pin = 5 };
const F6 = pinmap.pin{ .port = 5, .pin = 6 };
const F7 = pinmap.pin{ .port = 5, .pin = 7 };

//pub const

pub const alt_functions = enum {
    ADC,
    USART,
    TIMER,
    SPI,
};
