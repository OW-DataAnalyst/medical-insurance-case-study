# medical-insurance-case-study
Insurance Charges Analysis 


🎯 Problem biznesowy: Ubezpieczyciel chce zoptymalizować pricing, underwriting i programy prewencyjne poprzez zrozumienie, które czynniki (palenie, wiek, BMI, region, liczba dzieci) napędzają koszty medyczne klientów.

📊 Dane Tabela: insurance 


Kolumny:

age (int)

sex (male/female)

bmi (float)

children (int)

smoker (yes/no)

charges (float)

region (northeast/southeast/northwest/southwest)

✅ Quality checks

Liczba rekordów: 1 338

Duplikaty Transaction ID: brak

NULL: 0

Zakresy wartości:

age: 18–64

bmi: 15.96–53.13

charges: 1 121.87–63 770.43

Kategoryzacje poprawne: smoker ∈ {yes, no}, sex ∈ {male, female}, region ∈ {northeast, southeast, northwest, southwest}

📈 Wyniki i insighty

# 01_smoker_baseline.csv

Średnie koszty: palacze = 32 050.2, niepalący = 8 434.3

Diff = 23 616.0

Ratio = 3.80×

palacze generują prawie 4× wyższe koszty → konieczność wyższych składek i programów anti-smoking.


# 02_age_bands.csv
50+ = 17 902.6 (n=385)

40–49 = 14 399.2 (n=279)

30–39 = 11 738.8 (n=257)

18–29 = 9 182.5 (n=417)

Diff 50+ vs 18–29 = 8 720.1

Ranking: 50+ > 40–49 > 30–39 > 18–29

koszty rosną linearnie z wiekiem – kluczowy driver pricingu.


# 03_bmi_categories.csv
Obese = 15 479.5 (n=719)

Overweight = 10 994.0 (n=377)

Normal = 10 379.5 (n=222)

Underweight = 8 852.2 (n=20)

Diff Obese vs Normal = 5 100.0

Ranking: Obese > Overweight > Normal > Underweight

wyższy BMI koreluje z wyższymi kosztami → targetowane programy wellness.


# 04_region_median.csv
northeast = 10 057.7

southeast = 9 294.1

northwest = 8 965.8

southwest = 8 798.6

Diff max–min = 1 259.1


regiony o najwyższej medianie wymagają priorytetowych działań prewencyjnych.


# 05_smoker_premium_by_age.csv
18–29: avg_smoker = 27 518.0, avg_nonsmoker = 4 418.6, diff = 23 099.5, ratio = 6.23×

30–39: avg_smoker = 30 271.2, avg_nonsmoker = 6 337.4, diff = 23 933.9, ratio = 4.78×

40–49: avg_smoker = 32 654.7, avg_nonsmoker = 9 183.3, diff = 23 471.4, ratio = 3.56×

50+: avg_smoker = 38 748.3, avg_nonsmoker = 13 430.9, diff = 25 317.4, ratio = 2.89×

So what: efekt palenia na koszty maleje z wiekiem – wymagane cross-efekty w modelu pricingu.


# 06_bmi_smoker_interaction.csv
Obese: avg_smoker = 41 355.9, avg_nonsmoker = 8 829.5, diff = 32 526.4, ratio = 4.68×

Overweight: diff = 14 072.7, ratio = 2.69×

Normal: diff = 12 342.6, ratio = 2.62×

Underweight: diff = 13 276.8, ratio = 3.40×


najwyższe ryzyko kosztowe w segmencie Obese×smoker – priorytet dla underwriting’u.


# 07_sex_age_smoker.csv
18–29:

male: avg_smoker = 29 618.9 / avg_nonsmoker = 3 935.0 → ratio = 7.53×

female: avg_smoker = 24 735.8 / avg_nonsmoker = 4 911.0 → ratio = 5.04×

30–39: male ratio = 4.31×, female = 5.38×

40–49: male = 3.89×, female = 3.23×

50+: male = 3.05×, female = 2.71×


młodzi mężczyźni-palacze generują największą premię kosztową – personalizacja ofert wg płci i wieku.


# 08_quartiles_profile.csv
Q1: avg_age=23.8; avg_bmi=29.9; smoker_share=0.0%; avg_charges=2 853.1 (n=335)

Q2: avg_charges=6 999.0; smoker_share=0.0%

Q3: avg_charges=12 127.8; smoker_share=6.0%

Q4: avg_charges=31 151.7; smoker_share=76.0%

So what: najwyższy kwartyl to głównie palacze o wyższym BMI – główny target prewencji.


# 09_pareto_top20.csv
Top 20% (n=267) generuje 51.6% wszystkich kosztów

Profil: avg_age=42.7; avg_bmi=32.2; smoker_share=77.9%


niewielka grupa odpowiada za większość wydatków – indywidualne programy zarządzania ryzykiem.


# 10_risk_groups_case.csv
Top 3 segmenty wg sum_charges:

no_Obese_50+ (n=194) sum = 2 630 085.5

yes_Obese_50+ (n=42) sum = 1 956 839.9

yes_Obese_18-29 (n=45) sum = 1 654 230.8

Diff top vs bottom (no_Underweight_30-39 sum=18 635.0) = 2 611 450.5

So what: kluczowe kombinacje ryzyka wymagają dedykowanych polis i klauzul.


# 11_topN_by_risk_group.csv
Najwyższy pojedynczy koszt: 63 770.43 (yes_Obese_50+, age=54)

Kolejne outliery: 62 592.87 (yes_Obese_40-49), 58 571.07 (yes_Obese_30-39)

ekstremalni klienci potrzebują limitów i indywidualnych warunków.


# 12_children_effect_controlled.csv
0 dzieci: diff=23 729.6; ratio=4.12× (n=574)

1 dziecko: diff=23 519.5; ratio=3.83×

2 dzieci: diff=24 351.1; ratio=3.57×

3 dzieci: diff=23 110.4; ratio=3.40×

4 dzieci: diff=14 410.9; ratio=2.19×

5 dzieci: diff=10 839.4; ratio=2.32×

premia palacza najniższa przy 4–5 dzieciach, warto uwzględnić liczbę dzieci w taryfie.

💡 Rekomendacje końcowe

Wprowadzić dynamiczne taryfy uwzględniające cross-efekty palenia × BMI × wiek.

Dedykowane programy prewencyjne dla segmentów wysokiego ryzyka (smoker+Obese+50+).

Indywidualne limity i klauzule dla outlierów (charges > 60 000).

Skoncentrować działania na top 20% klientów (51.6% kosztów).

Uwzględnić liczbę dzieci i płeć jako modyfikatory ryzyka.

📂 Wyniki (folder results/)

Plik	Opis
01_smoker_baseline.csv	Baseline palenia (avg_smoker vs avg_nonsmoker)
02_age_bands.csv	Średnie koszty wg pasm wieku
03_bmi_categories.csv	Średnie koszty wg kategorii BMI
04_region_median.csv	Mediana kosztów wg regionu
05_smoker_premium_by_age.csv	Diff & ratio palacz vs niepalący w grupach wiekowych
06_bmi_smoker_interaction.csv	Interakcja BMI × palenie (diff & ratio)
07_sex_age_smoker.csv	Pivot: płeć × wiek × palenie
08_quartiles_profile.csv	Kwartyle kosztów i profil kwartylowy
09_pareto_top20.csv	Pareto top 20% klientów
10_risk_groups_case.csv	Segmenty ryzyka (smoker + BMI + wiek)
11_topN_by_risk_group.csv	Top 3 rekordy w każdym segmencie ryzyka
12_children_effect_controlled.csv	Wpływ liczby dzieci na koszty wg palenia
