# Data-Cleaning-and-Preprocessing-sql-

One of my first SQL projects, I cleaned a 2K+ rows raw dataset of layoffs worldwide using CTEs, Join, WindowFunctions, etc.

The Layoff Sql script and the database are included. 

Trimmed the extra spaces in the company's names and changed the date format from text to date.
--

![Screenshot 2025-02-28 144544](https://github.com/user-attachments/assets/be82d0df-16c6-4f7e-8b93-31325ccb2eeb)

Data had Company names with missing industry records, so I populated them using joins
--

![Screenshot 2025-02-28 151003](https://github.com/user-attachments/assets/4cc4fb3c-98a1-4d9c-a5d2-bc05ec75ac2e)
![Screenshot 2025-02-28 151400](https://github.com/user-attachments/assets/ad0774da-335b-4c48-8100-e6ab6019e135)
![Screenshot 2025-02-28 151511](https://github.com/user-attachments/assets/85638d8b-7bc2-4a39-835d-7aefdcac2342)



THE DATA BEFORE included columns irrelevant to the Layoffs with no record of layoffs.
--

![Screenshot 2025-02-28 144031](https://github.com/user-attachments/assets/66f13684-2f01-4a75-bad0-6c181894fd27)

Fixed it by deleting the NULL records from the total_laid_off and percentage_laid_off.
--
![Screenshot 2025-02-28 144338](https://github.com/user-attachments/assets/c88b6df7-8cb1-4b74-b4f4-fae4c83dd9cb)
