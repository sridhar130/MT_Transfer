#-----------------------------------------------------------------------------------------
#--------------------Description of #PRM---------------------------------------------------
#-----------------------------------------------------------------------------------------


There are 4 files with respect to PRM. For understanding and subsequent implementation 2 sets of files are there.

------(1)----------------
sort_with_angle_Transfer.m
PatternReconition_Transfer.m
------(2)----------------
Acumuracy_hist.m
PRM_2_Transfer.m
--------------------------

NB: Either go with the codes in (1) or by (2). Both ways are independent. (1) is the old implementation, (2) is the newer one.

------(1)----------------
sort_with_angle_Transfer.m:

POCA/BCA scattering points and angles are used (HH-files).
The files is sorted like a histogram in an XY array
Angle is collected in another dimension.
NY is the output matrix.

PatternReconition_Transfer.m

Input is NY matrix from the previous code.
Filtering is done based on the sub-matrix/filter obtained from the region which has highest occupancy. Different factors such as div by 2 or 3 is used to segregate materials of different density.
Filtering is applied and the output matrix NY and the second dimension NN2 is used for plotting.



------(2)----------------
Acumuracy_hist.m

POCA/BCA scattering points and angles are used (HH-files).
Sorting is done with 'accumarray' function. It projects the coordinates in XY-array or histogram like structure.
Scattering angle/S-parameter is assigned with it.
Filter-matrix/sub-matrix 'AB' is obtained from observation, mAB, stdAB are also obtained.
The XY-arrays are saved as H-file, with S-parameters.

PRM_2_Transfer.m

Input os H-file from the previous code. 
Filter-matrix/sub-matrix 'F' is constrcuted using mAB and stdAB.
Filtering is carried out in 4 possible directions. Representative pixels are plotted wrapped over the scattered plots to represent the filtered pixels.



--------------------------------------------------------------
------Different between new and old implementation------------
--------------------------------------------------------------

The old implementaion: (1) and new one: (2) are independent of each other. In (1), the most-dense (regions with highest scattering events) are found. If a less dense object is found ,that is rejected. In this way a high-pass filter approach is taken. To make the PRM more robust, in (2) the filter matrix is chosen from 'Acumuracy_hist.m' (histogram/array making code) and not in the main PRM code. This way, mAB and stdAB for severak different materials can be collected and passed to the main PRM code for filtering.







***-----------------------------------------------------***
Test-file: HH_CFST_NoDef_4e8_Theta30.txt

It contains the HH-files in the format::

X-coordinate:Y-coordinate:Scattering angle

Description of the target::
The file contains POCA output for a CFST without any defect for 4e8 elements. 

Detector Resolution:: 200um

Detector size: 70cm

Cuts:
Events with scattering angle more than 10 mrad are selected.

Incoming muons with incoming angle < 30 deg with zenith are selected.

 







