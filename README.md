# mjc284_fpga_communication
Personal electronic project to create SPI, I2C, and UART drivers on the fpga.

## Concept
The focus of this project is to implement custom SPI, I2C, and UART drivers and study these methods of communication in depth. The project attempts to account for the difference in clock phase and frequency between different devices by using FIFO registers. The SPI communication in particular is solely controlled by the master's clock signal. Therefore, the FIFO allows data to be bridged between the master and slave's differing clock signals.

## Modules

### SPI Slave and FIFO
![SPI_Slave](/circuit/SPI_Slave_annotated.png "SPI_Slave")
Two modules were designed to make a complete spi slave module, which consists of two shift registers for the MOSI and MISO data (with a counter to signal the end of each 8-bit data transfer), and two FIFO buffers for the recieving and sending ends. A key subcomponent that plays an important role here is the FIFO pointer. The FIFO pointer is basically a bi-directional shift register that shifts a single 'on' bit to the right on the 'write' signal and left on the 'read' signal. This way, the position of the 'on' bit indicates the address of the first data that hasn't been read yet. On the recieving end of the spi slave, the counter that signals the end of 8-bit data transfered sets the 'write' signal while writing data into the FIFO input, and whatever module that recieves the spi data sets the 'read' signal before reading from the FIFO output. This is similar for the sending end where the writing module sets the 'write' input and the counter sets the 'read' input.

