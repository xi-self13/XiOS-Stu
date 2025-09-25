// TODO: Add the important stuff here. - XI


// Volatile tells compiler to not break the build or optimize it away.
volatile unsigned short *video_memory = (unsigned short *)0xB8000;


void kmain() {
    // My simple little message!
    const char *message = "Hello, world, XiOS is atleast printing this message! ;1"
    int screen_pos = 0; // I believe this is centered

    unsigned char attributes = 0x0f; // White text on black bg

    // Clear contents
    for (int i = 0; i < 80 * 25; i++) {
        // ' ' 
        video_memory[i] = ' ' | (attributes << 8);
    }
    // Lets print the char on screen :)
    for (int i = 0; message[i] != '\0'; ++ )

}