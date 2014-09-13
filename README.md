# Algorithms for Tracking and Identifying People in the Image by using Machine Learning Methods
Martin Kersner, m.kersner@gmail.com

Promotion video: https://www.youtube.com/watch?v=2cXOL0TAWj8
Final paper: [PDF](https://dl.dropboxusercontent.com/u/13642345/Algorithms-for-Tracking-and-Identifying-People-in-the-Image-by-using-Machine-Learning-Methods.pdf)

Detection, tracking and gender recognition has become fundamental task of surveillance systems. Price of depth sensors is still falling and therefore enables discover new methods based only on depth information. This paper focuses on techniques which can be exploited using depth maps. Detection and tracking make do only with smart usage of histogram. We propose new method of estimation of human body orientation based on derived features from gradient line. Our method nearly achieves the same accuracies as common techniques. However, the best results were reached by method called Histogram Of Oriented Gradients. This feature extraction method and linear SVM classifier obtained 96.4% for estimation of human body orientation and 99% for gender recognition.

http://surmon.org/summer-camp-2014/martin-kersner/

The aim of the project is to track and identify walking people from the top view. For these purposes will be used RGB and depth images which will be concurrently recorded. Segmentation algorithms using depth information will be designed and the observed subjects will be tracked. The features describing visual appearance of subjects will be extracted and used for creating model using Machine Learning methods. Model will be able to assign an identification to particular subjects. The identification represents an additional person’s characteristics obtained from the examined images. The characteristics, which are more difficult to detect by the cameras, are such as gender, height, etc. The results of the tracking and identified characteristics of observed subjects will be recorded, the performance will be evaluated and the results will be visualized in an appropriate form. The algorithms will be implemented in Java using the OpenCV library.
