const usb_reg = packed struct {
    ep: [8]u32,
    res: [8]u32,
    cntr: u32,
    istr: u32,
    fnr: u32,
    daddr: u32,
    btable: u32,
};

pub fn do_thing() bool {
    var reg = @intToPtr(*usb_reg, 0x12345);
    if (reg.ep[0] == 1)
        return true;
    return false;
}

comptime {
    const val = @offsetOf(usb_reg, "cntr") == 0x40;
    @import("std").debug.assert(val);
}

//usbd_dev = usbd_init(&st_usbfs_v1_usb_driver, &dev, &config, usb_strings, 3, usbd_control_buffer, sizeof(usbd_control_buffer));
//        usbd_register_set_config_callback(usbd_dev, cdcacm_set_config);

pub const device_descriptoon = packed struct {
    bLength: u8,
    bDescriptorLength: u8,
    bcdUSB: u16,
    bDeviceClass: u8,
    bDeviceSubClass: u8,
    bDeviceProtocol: u8,
    bMaxPAcketSize0: u8,
    idVector: u16,
    idProduct: u16,
    bcdDevice: u16,
    iManufacturer: u8,
    iProduct: u8,
    iSerialNumber: u8,
    bNumConfigurations: u8,
};

pub const DescriptorType = enum(u8) {
    device = 1,
    configuration = 2,
    string = 3,
    interface = 4,
    endpoint = 5,
    device_qualifier = 6,
    otehr_speed_configuration = 7,
    interface_power = 8,
};

pub const attribute = struct {
    pub const Control: u8 = 0x0;
    pub const Isochonous: u8 = 0x1;
    pub const Bulk: u8 = 0x2;
    pub const Interrupt: u8 = 0x3;
    pub const Nosync: u8 = 0x00;
    pub const Async: u8 = 0x04;
    pub const Adaptive: u8 = 0x08;
    pub const Sync: u8 = 0x0C;
    pub const SyncType: u8 = 0x0C;
    pub const Data: u8 = 0x00;
    pub const Feedback: u8 = 0x10;
    pub const ImplicitFeedbackData: u8 = 0x20;
    pub const UsageType: u8 = 0x30;
};

pub const EndpointDescriptor = packed struct {
    pub fn init(descriptor_type: DescriptorType, addr: u8, atribute: u8, max_packet_size: u8, interval: u8) EndpointDescriptor {
        return .{
            .bLength = @sizeof(@This()),
            .bDescriptorType = descriptor_type,
            .bEndpointAddress = addr,
            .bmAttributes = attribute,
            .wMaxPacketSize = max_packet_size,
            .bInterval = interval,
        };
    }
    bLength: u8,
    bDescriptorType: u8,
    bEndpointAddress: u8,
    bmAttributes: u8,
    wMaxPacketSize: u16,
    bInterval: u8,
};

pub const config_descriptor = packed struct {
    bLength: u8,
    bDescriptoType: u8,
    WTotalLength: u16,
    bNumInterfaces: u8,
    bConfigurationValue: u8,
    iConfiguration: u8,
    bmAtributes: u8,
    bMaxPower: u8,
};
