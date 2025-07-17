part of '../_pages.dart';


class ControllerDonation extends GetxController{

  final selectedAmount = 0.obs;

  final RxList<DonationOrganizationSimple> donationSummaries = [
    DonationOrganizationSimple(
      image: "https://images.unsplash.com/photo-1509099836639-18ba02f0b9b8",
      name: "Hope for Children",
      fundraisedAmount: "\$31500",
    ),
    DonationOrganizationSimple(
      image: "https://images.unsplash.com/photo-1587502537745-84b48f77c9aa",
      name: "Green Earth Foundation",
      fundraisedAmount: "\$48300",
    ),
    DonationOrganizationSimple(
      image: "https://images.unsplash.com/photo-1603393071235-118d5d6c48c4",
      name: "Water For All",
      fundraisedAmount: "\$18700",
    ),
    DonationOrganizationSimple(
      image: "https://images.unsplash.com/photo-1565372914781-2be7a040af24",
      name: "Animal Rescue Alliance",
      fundraisedAmount: "\$39200",
    ),
    DonationOrganizationSimple(
      image: "https://images.unsplash.com/photo-1580633018526-3c0f0b4b7a2b",
      name: "Global Health Initiative",
      fundraisedAmount: "\$78600",
    ),
  ].obs;
}