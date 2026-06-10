import 'package:flutter/material.dart';
import 'package:princess_app/core/constants/app_colors.dart';

class ProfileAvatar extends StatefulWidget {
  final ValueChanged<String>? onAvatarChanged;

  const ProfileAvatar({super.key, this.onAvatarChanged});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  // Mock image index
  int _avatarIndex = 0;

  final List<String> _mockUrls = [
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Princess1',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Princess2',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Princess3',
  ];

  void _cycleAvatar() {
    setState(() {
      _avatarIndex = (_avatarIndex + 1) % _mockUrls.length;
    });
    widget.onAvatarChanged?.call(_mockUrls[_avatarIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Outer Glow Container
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 54,
              backgroundColor: AppColors.cardBg,
              backgroundImage: AssetImage('assets/images/avatar_profile.png'),
            ),
          ),

          // Action button
          Positioned(
            bottom: 2,
            right: 2,
            child: InkWell(
              onTap: _cycleAvatar,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
