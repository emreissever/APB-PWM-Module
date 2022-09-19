# My Notes

## Brief Introduction to PWM

**P**ulse **W**idth **M**odulation (PWM), is a modulation technique widely used in microcontrollers. Although this modulation technique can be used to encode information for transmission, its main use is to allow the control of the power supplied to electrical devices by providing analog output pins to the microcontroller.

---

## Brief Introdcution to APB Protocol

**A**dvanced **P**eripheral **B**us (**APB**) is part of the **A**dvanced **M**icrocontroller **B**us **A**rchitecture (**AMBA**) protocol family. It defines a low-cost interface that is optimized for minimal power consumption and reduced interface complexity.

The APB protocol is not pipelined, use it to connect to low-bandwidth peripherals that do not require the high performance of the AXI protocol.

Mostly, used to connect the external peripheral to the SoC. In APB, every transfer takes at least two clock cycles (Setup Cycle and Access Cycle) to complete. It can also interface with AHB and AXI protocols using the bridges in between.

The APB Specification released in 1998, is now obsolote and is superseded by the following three revisions: 

* [AMBA 2 APB Specification](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiG_vbA69j5AhXeVfEDHVtVASIQFnoECAwQAQ&url=https%3A%2F%2Fdocumentation-service.arm.com%2Fstatic%2F5f916403f86e16515cdc3d71%3Ftoken%3D&usg=AOvVaw3I4Y5NBAiCiopnHM_VqpXd) (Referred as APB2)

    * This specification defines the interface signals, the basic read and write transfers.

  <br>

* [AMBA 3 APB Protocol Specification v1.0](https://web.eecs.umich.edu/~prabal/teaching/eecs373-f12/readings/ARM_AMBA3_APB.pdf) (Referred as APB3)
  
    * This version of Specification defines additional functionality: *Wait states*, *Error Reporting*
    * Following interface signals support this functionality:
      * `PREADY` : A ready signal to indicate completion of an APB transfer.
      * `PSLVERR` : An error signal to indicate the failure of a transfer.

<br>

* [AMBA APB Protocol Specification v2.0](https://www.eecs.umich.edu/courses/eecs373/readings/IHI0024C_amba_apb_protocol_spec.pdf) (Referred as APB4)

    * This version of specification defines additional functionality: *Transaction Protection*, *Sparse Data Transfer*.
    * Following interface signals support this functionality:
      * `PPROT` : A protection signal to support both non-secure and secure transactions on APB.
      * `PSTRB` : A write strobe signal to enable sparse data transfer on the write data bus.

> This PWM Module Supports APB 3 (AMBA 3 APB Protocol Specification v1.0)
