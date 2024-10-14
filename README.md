# P10K-Network-Segments
A few usefull (network related) [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt segments.

# Usage

Just download ``networksegments.zsh`` to a place where you want, then add ``source /path/to/networksegments.zsh`` to your ``.p10k.zsh`` and add the segments you want to use either to the left or the right prompt.

## Segments

### my\_wired\_ip
Shows the ip of your first connected wired interface (the interface needs a ipv4 address and the interface name must match Regex ``[Ee]\w+``)

### my\_wifi\_ip
Shows the ip of your first connected wireless interface (the interface needs a ipv4 address and the interface name must match Regex ``[Ww]\w+``)

### my\_if\_count
Shows the number of connected interfaces which meet the Regex criteria of the last two segments and have an ipv4 address. Also works without the other segments.

# Configuration
All the segments work without any configuration. If you want, you can change a few things at the top of the ``networksegments.zsh`` file.
Everything above "BEGIN OF SEGMENTS" is used to to controll the behavior of the segments. 
