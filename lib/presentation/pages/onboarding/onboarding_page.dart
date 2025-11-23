import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import '../../core/constant/routes_values.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<_OnboardingSlide> _slides = const [
    _OnboardingSlide(
      title: 'Create Trip Plan',
      description:
      'Set destinations, dates, and organize your travel plans with ease.',
      placeholderLabel: 'Trip Illustration',
      illustrationAsset: 'assets/illustrations/Trip.svg',
    ),
    _OnboardingSlide(
      title: 'Traveler Information',
      description:
      'Save traveler details, documents, and important contacts in one place.',
      placeholderLabel: 'Traveler Illustration',
      illustrationAsset: 'assets/illustrations/Traveler.svg',
    ),
    _OnboardingSlide(
      title: 'Add Packing List',
      description:
      'List essentials and check off items as you prepare for your trip.',
      placeholderLabel: 'Packing Illustration',
      illustrationAsset: 'assets/illustrations/Packing.svg',
    ),
    _OnboardingSlide(
      title: 'Languages & Phrases',
      description:
      'Save useful phrases and quick translations for your journey.',
      placeholderLabel: 'Phrases Illustration',
      illustrationAsset: 'assets/illustrations/Phrases.svg',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final settingsBox = Hive.box('settingBox');
    await settingsBox.put('onboardingCompleted', true);
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(RoutesValues.home, (route) => false);
  }

  void _onNextPressed() {
    if (_currentIndex == _slides.length - 1) {
      _completeOnboarding();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPrevPressed() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop(animated: true);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Container(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                slide.illustrationAsset,
                                width: MediaQuery.of(context).size.width * 0.9,
                                fit: BoxFit.contain,
                                color: Theme.of(context).iconTheme.color,
                                semanticsLabel: slide.placeholderLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            slide.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              slide.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: _currentIndex == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Theme.of(context).iconTheme.color
                          : Theme.of(context).iconTheme.color?.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Row(
                  children: [
                    if (_currentIndex != 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _onPrevPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).iconTheme.color,
                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                    if (_currentIndex != 0) const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _onNextPressed,
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).iconTheme.color,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: Text(
                          _currentIndex == _slides.length - 1 ? 'Continue' : 'Next',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.placeholderLabel,
    required this.illustrationAsset,
  });

  final String title;
  final String description;
  final String placeholderLabel;
  final String illustrationAsset;
}
