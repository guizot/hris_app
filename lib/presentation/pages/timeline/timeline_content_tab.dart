import 'package:flutter/material.dart';

class TimelineContentTab extends StatefulWidget {
  const TimelineContentTab({super.key});

  @override
  State<TimelineContentTab> createState() => _TimelineContentTabState();
}

class _TimelineContentTabState extends State<TimelineContentTab> {
  final List<Map<String, dynamic>> _posts = [
    {
      "author": "John Doe",
      "role": "Product Manager",
      "avatar": "https://ui-avatars.com/api/?name=John+Doe&background=random",
      "content": "Just wrapped up an amazing sprint planning session! Excited about the new features we're building for Q1 2026. 🚀",
      "timestamp": "2 hours ago",
      "likes": 12,
      "comments": 3,
      "isLiked": false,
    },
    {
      "author": "Alice Smith",
      "role": "UI Designer",
      "avatar": "https://ui-avatars.com/api/?name=Alice+Smith&background=random",
      "content": "Check out the new design system I've been working on! Can't wait to share the full presentation next week. 🎨✨",
      "timestamp": "4 hours ago",
      "likes": 24,
      "comments": 7,
      "isLiked": true,
    },
    {
      "author": "Bob Jones",
      "role": "Senior Developer",
      "avatar": "https://ui-avatars.com/api/?name=Bob+Jones&background=random",
      "content": "Successfully deployed the new authentication system to production. Zero downtime! 💪 Thanks to the amazing DevOps team for the support.",
      "timestamp": "6 hours ago",
      "likes": 18,
      "comments": 5,
      "isLiked": false,
    },
    {
      "author": "Diana Prince",
      "role": "Team Lead",
      "avatar": "https://ui-avatars.com/api/?name=Diana+Prince&background=random",
      "content": "Proud of our team for hitting all our milestones this month! Let's keep up the momentum. 🎯",
      "timestamp": "8 hours ago",
      "likes": 31,
      "comments": 9,
      "isLiked": true,
    },
    {
      "author": "Charlie Day",
      "role": "Product Owner",
      "avatar": "https://ui-avatars.com/api/?name=Charlie+Day&background=random",
      "content": "Great feedback from our client meeting today. They loved the new dashboard features! 📊",
      "timestamp": "1 day ago",
      "likes": 15,
      "comments": 4,
      "isLiked": false,
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      _posts[index]['isLiked'] = !_posts[index]['isLiked'];
      _posts[index]['likes'] += _posts[index]['isLiked'] ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 120),
        itemCount: _posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _buildPostCard(context, post, index);
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Map<String, dynamic> post, int index) {
    return Material(
      color: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Open post details
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post['avatar']),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['author'],
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          post['role'],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    post['timestamp'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Post content
              Text(
                post['content'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              // Action buttons
              Row(
                children: [
                  _buildActionButton(
                    context,
                    icon: post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                    label: '${post['likes']}',
                    color: post['isLiked'] ? Colors.red : null,
                    onTap: () => _toggleLike(index),
                  ),
                  const SizedBox(width: 24),
                  _buildActionButton(
                    context,
                    icon: Icons.comment_outlined,
                    label: '${post['comments']}',
                    onTap: () {
                      // TODO: Open comments
                    },
                  ),
                  const SizedBox(width: 24),
                  _buildActionButton(
                    context,
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () {
                      // TODO: Share post
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    final buttonColor = color ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: buttonColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
