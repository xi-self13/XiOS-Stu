/* Lets start the program here... */
ENTRY(start)
SECTIONS
{
    . = 1M;
    .text :
    {
        *(.multiboot_header)
        *(.text)
    }
    .bss :
    {
        *(.bss)
    }
}