import '../app_images.dart';

class CountryModel {
  final String countryName;
  final String countryFlag;

  CountryModel({required this.countryName, required this.countryFlag});
}

List<CountryModel> countryList = [
  CountryModel(countryName: "Global", countryFlag: AppImages.plainImage),
  CountryModel(countryName: "India", countryFlag: AppImages.indiaFlag),
  CountryModel(countryName: "Japan", countryFlag: AppImages.japanFlag),
  CountryModel(countryName: "Australia", countryFlag: AppImages.australiaFlag),
  CountryModel(countryName: "China", countryFlag: AppImages.chinaFlag),
  CountryModel(countryName: "Korea", countryFlag: AppImages.southKoreaFlag),
  CountryModel(countryName: "USA", countryFlag: AppImages.usaFlag),
  CountryModel(countryName: "Germany", countryFlag: AppImages.germanyFlag),
  CountryModel(countryName: "Canada", countryFlag: AppImages.canadaFlag),
  CountryModel(countryName: "UK", countryFlag: AppImages.ukFlag),
  CountryModel(countryName: "South Africa", countryFlag: AppImages.southAfricaFlag),
];
