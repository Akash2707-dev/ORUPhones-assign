import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/faw_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FaqExpansionTile extends StatelessWidget {
  const FaqExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaqViewModel>.reactive(
      viewModelBuilder: () => FaqViewModel(),
      onViewModelReady: (viewModel) => viewModel.fetchFaqs(),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.faqs.isEmpty) {
          return const Center(
            child: Text(
              "No FAQs available.",
              style: TextStyle(fontSize: 16, color: Color(0xFF7B7B7B)),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: List.generate(viewModel.faqs.length, (index) {
              final faq = viewModel.faqs[index];
              final isExpanded = viewModel.expandedStates[index];

              return Column(
                children: [
                  /// **FAQ Question Row (Fixed Height & Clickable)**
                  GestureDetector(
                    onTap: () => viewModel.toggleExpansion(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5), // ✅ Grey Background
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// **FAQ Question (Max 2 Lines)**
                          Expanded(
                            child: Text(
                              faq["question"] ?? "No question",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2, // ✅ Allows 2 lines max
                              overflow:
                                  TextOverflow.ellipsis, // ✅ Adds "..." if more
                            ),
                          ),

                          /// **Animated Expand/Collapse Icon**
                          AnimatedRotation(
                            turns: isExpanded
                                ? 0.25
                                : 0.0, // ✅ Rotates + into X smoothly
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.add,
                                size: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// **FAQ Answer (Expandable with Animation)**
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white, // ✅ White Background for Answer
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: Text(
                        faq["answer"] ?? "No answer",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black87),
                      ),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(
                        milliseconds: 300), // ✅ Smooth expansion animation
                  ),

                  /// **Spacing Between FAQs**
                  const SizedBox(height: 10),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
