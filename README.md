# Project 4

## Eigenfaces

#contents
- 'main_eigenface.m'
main script to produce eigenface images
- 'get_faces_dataset.m'
read data set
- 'pc.m'
calculate Principal Components

#how to run the codes
run 'main_eigenface.m' to produce 
- eigenfaces
- reconstructed image
- weights and Eucidean distanses

>make sure the parameter of getting training and test data in the function 'get_faces_dataset'
- path: curently 'datt_faces' is assigned
- shuffle: whether randomize the order (shuffle = true)  of data or not (shuffle = 0) 
- M: numbers of the people (1 ≤ M ≤ 40)
- n: numbers of the sample (1 ≤ n ≤ 10)
- InputImage: the file name of new input image


## Classification

Note that both of these programs require the following folders/data in the current working directory:

- att_faces
  - s1
    - 1.pgm
    - 2.pgm
    - ......
    - 10.pgm
  - s2
    - ......
  - ......
  - s40
    - ......
- data
  - non_faces
    - 0.png
    - 1.png
    - .......
    - 9.png

The programs will create subdirectories inside of ./data and copy att_faces images to these subdirectories.

To run the facial recognition program, type the following in the MatLab command window

> [~, accuracy] = recognition(k)

where k is the number of eigenfaces to use. For example, recognition(28).

To run the facial identification program, type the following in the MatLab command window

> [accuracy, fmeasure] = identification(p, v)

where p is the degree of polynomial expansion (use 0 for no expansion) and v is the proportion of variance that PCA should capture (use 0 for no PCA). For example, identification(0, .90) or identification(2, .75).
