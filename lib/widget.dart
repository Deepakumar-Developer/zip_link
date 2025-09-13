import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zip_link/functions/app_function.dart';

class ZipText extends StatefulWidget {
  final String str;
  final double size;
  final Color color;
  final FontWeight weight;
  const ZipText({
    super.key,
    required this.str,
    required this.size,
    this.color = Colors.white,
    this.weight = FontWeight.w700,
  });

  @override
  State<ZipText> createState() => _ZipTextState();
}

class _ZipTextState extends State<ZipText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.str,
      style: GoogleFonts.overlockSc(
        fontSize: widget.size,
        fontWeight: widget.weight,
        color: widget.color,
      ),
    );
  }
}

class UrlInput extends StatefulWidget {
  final TextEditingController controller;
  const UrlInput({super.key, required this.controller});

  @override
  State<UrlInput> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: width(context),
          height: 268,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZipText(
                    str: 'Enter URL',
                    size: 16,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  IconAsButton(
                    icon: Icons.content_paste_go_rounded,
                    onPressed: () async {
                      bool status = await pasteFromClipboard(context, widget.controller);

                      if(status) {
                        setState(() {
                        show = true;
                      });
                      }
                    },
                  ),

                  // SizedBox(
                  //   width: 8,
                  // ),
                ],
              ),
              Divider(color: Colors.white60),
              SizedBox(height: 6),
              TextField(
                controller: widget.controller,
                readOnly: true,
                keyboardType: TextInputType.url,
                minLines: 6,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Ctrl + V or Use button to paste',
                  hintStyle: GoogleFonts.ubuntu(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                style: GoogleFonts.ubuntu(
                  fontSize: 12,
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
              ),
            ],
          ),
        ),
        Visibility(
          visible: show,
          child: Container(
            margin: EdgeInsets.all(8),
              decoration:BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),child: IconAsButton(icon: Icons.link, onPressed: (){
            launchURL(widget.controller.text,context);
          })),
        )
      ],
    );
  }
}

class IconAsButton extends StatefulWidget {
  final IconData icon;
  final void Function() onPressed;
  const IconAsButton({super.key, required this.icon, required this.onPressed});

  @override
  State<IconAsButton> createState() => _IconAsButtonState();
}

class _IconAsButtonState extends State<IconAsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Icon(widget.icon, size: 22, color: Colors.white),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final String name;
  final void Function() onPressed;
  const MyButton({super.key, required this.name, required this.onPressed});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: width(context),
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Center(
          child: ZipText(
            str: widget.name,
            size: 16,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ZippedLinkField extends StatefulWidget {
  const ZippedLinkField({super.key});

  @override
  State<ZippedLinkField> createState() => _ZippedLinkFieldState();
}

class _ZippedLinkFieldState extends State<ZippedLinkField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: Colors.white54, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          code.isEmpty ? Text(
            'https://ziplink.com/',
            style: GoogleFonts.ubuntu(
              fontSize: 18,

            ),
          ) : GradientText('https://ziplink.com/$code', size: 18),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: IconAsButton(
              icon: Icons.copy_rounded,
              onPressed: () async {
                await copyToClipboard(context, code);
                print('Copy button pressed');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.size, this.underline = true});

  final String text;
  final double size;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
          fontSize: size,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
