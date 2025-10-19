import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/core/consts/app_colors.dart';

// An enum to represent different card types for clarity
enum CardType { Visa, Mastercard, AmericanExpress, Discover, Unknown }

class ProfessionalVisaField extends StatefulWidget {
  const ProfessionalVisaField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onSaved,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;

  @override
  State<ProfessionalVisaField> createState() => _ProfessionalVisaFieldState();
}

class _ProfessionalVisaFieldState extends State<ProfessionalVisaField> {
  CardType _cardType = CardType.Unknown;

  @override
  void initState() {
    super.initState();
    // Add a listener to the controller to detect changes in real-time
    widget.controller.addListener(_detectCardType);
  }

  @override
  void dispose() {
    // Clean up the listener when the widget is removed
    widget.controller.removeListener(_detectCardType);
    super.dispose();
  }

  void _detectCardType() {
    String number = widget.controller.text.replaceAll(' ', '');
    CardType newType = CardType.Unknown;

    // Use regular expressions to detect card brand
    if (RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(number)) {
      newType = CardType.Visa;
    } else if (RegExp(r'^5[1-5][0-9]{14}$').hasMatch(number)) {
      newType = CardType.Mastercard;
    } else if (RegExp(r'^3[47][0-9]{13}$').hasMatch(number)) {
      newType = CardType.AmericanExpress;
    } else if (RegExp(r'^6(?:011|5[0-9]{2})[0-9]{12}$').hasMatch(number)) {
      newType = CardType.Discover;
    }

    // Update the state only if the card type has changed
    if (newType != _cardType) {
      setState(() {
        _cardType = newType;
      });
    }
  }

  // Helper to get the logo asset based on the card type
  Widget _getCardLogo() {
    switch (_cardType) {
      case CardType.Visa:
        // IMPORTANT: Add these images to your assets folder!
        return Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png',
          width: 40,
        );
      case CardType.Mastercard:
        return Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/2560px-Mastercard-logo.svg.png',
          width: 40,
        );
      // Add other cases for Amex, Discover, etc.
      default:
        // Return a default icon when the type is unknown
        return const Icon(Icons.credit_card, color: Colors.grey, size: 28);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      // 1. Strict Input Control
      keyboardType: TextInputType.number,
      maxLength: 16, // Automatically limits to 16 characters
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Allow only numbers
      ],
      onSaved: widget.onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Card number is required.';
        }
        if (value.length != 16) {
          return 'Please enter a valid 16-digit card number.';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Enter Visa Card Number',
        hintText: '•••• •••• •••• ••••',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 20.0,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: _getCardLogo(),
        ),
        // Hide the default "0/16" counter text for a cleaner look
        counterText: '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          // Assuming AppColors.primary exists
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
      ),
    );
  }
}
