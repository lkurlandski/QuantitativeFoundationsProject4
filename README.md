# Project 4

## Eigenfaces

#how to run the codes
run 'main.m' to check the accuracy of PCA on face recognition

>make sure the parameter of getting training and test data in the function 'get_faces_dataset'
- path: curently 'data/att_faces' is assigned
- shuffle: whether randomize the order (shuffle = 1)  of data or not (shuffle = 0) 
- people/samples: numbers (labels) of the data (1 ≤ people ≤ 40, 1 ≤ samples ≤ 10)

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
  ......
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

> recognition(k)

where k is the number of eigenfaces to use. For example, recognition(28).

To run the facial identification program, type the following in the MatLab command window

> identification(p, v)

where p is the degree of polynomial expansion (use 0 for no expansion) and v is the proportion of variance that PCA should capture (use 0 for no PCA). For example, identification(0, .90) or identification(2, .75).
