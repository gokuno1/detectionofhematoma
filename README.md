# Detection and Classification of Brain Hematoma Using SVM, Random Forest and Neural Networks

Overview:
In this we are classifying brain hematoma which is a type of traumatic brain injury where blood clots in brain causing deaths in some cases. There are three types of hematomas: 1)EDH 2)SDH 3)ICH
Each type has different different shapes and different positions.

In this project we used matlab for image processing and machine learning part.
We created dataset from 46 CT scanned images and split data into training and testing data (Using 80-20% rule)
Image processing:
filtered image
removed noise
removed skull
Finally, extracted hematoma from brain image.

Using region based segemntation, calculated statistical characteristics of extracted hematoma image.
All the characteristics calculated were stored in excel sheet and using that excel sheet we created machine learning model
using classification learner.
Using that model, predicted which kind of hematoma is present in Brain.
