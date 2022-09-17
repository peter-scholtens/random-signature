###### *(For the original [presentation](https://linuxnijmegen.nl/images/pdf/SignatureOfAnEvangelist.pdf) in Dutch look here)*

# Random Signatures

A collection of my scripts to select randomly an e-mail signature. Hopelfully this may encourage you to add a positive advertisement in your email signatures too. The random signatures can be used for any e-mail client which can read a file from a location on the disc, but as an example [Thunderbird](https://www.thunderbird.net) is used for setting the corrects file paths. How? First of all download the repository with:
```
git clone https://github.com/peter-scholtens/random-signature.git
```

### Using a *UNIX-pipe* for creating random messages
With the script simple_random_reply_server.bash you can see how a named pipe can be used. Simple do the following to start the server process:
```
cd random-signature
./simple_random_reply_server.bash
```
In another terminal you now can do:
```
cd random-signature
cat my_random_signature 
```
Re-try this `cat` command several times and you will see that it varies randomly. If your e-mail client really reads the named pipe from start to end in one go, so without restarting, then you can use this method to assign varying signatures to youe e-mail: simply expand the `case` statement in it, while also increasing the operand `4` in the module operator `%` of the script.

### Using a *symbolic link* for creating random messages

However, Thunderbird, and possible other modern e-mail clients too, will attempt to read the named pipe several times, e.g. the first time to detect the type, the second time to process it. In this case a named pipe with a randomly varying content will not work properly. In that case make you of the script symlink_server_thunderbird.bash which uses a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link) to select varying message. If you have already downloaded the repository, do the following to start a re-linker server:
```
cd random-signature
./symlink_server_thunderbird.bash
```
In another terminal you can now do:
```
ls -l ~/.thunderbird/random_signature_fifo.html
```
You'll see that the filename refers `->` to another randomly chosen file. Re-try the `ls` command after ten seconds and see that it has changed. You can use this to read a different signature for every mail you send.

### Select your random signature generator in Thunderbird
In Thunderbird you can do that by following the pulldown menu path `Edit` -> `Account Settings` and select the e-mailaddress which you want to attach the generator to. Then **switch on** the checkbox of the option `Attach the signature from a file instead`, and choose the correct path towards the symbolic link.
