# Simulator of IRIS-U^2 (Incremental Random Inspection-roadmap Search Under Uncertainty) - 

This is code for the simulator used in the paper **Inspection planning under execution uncertainty**. To cite this work, please use:

```
@article{alpert2023inspection,
  title={Inspection planning under execution uncertainty},
  author={Alpert, Shmuel David and Solovey, Kiril and Klein, Itzik and Salzman, Oren},
  journal={arXiv preprint arXiv:2309.06113},
  year={2023}
}
```
You can find the paper [here](https://arxiv.org/pdf/2309.06113.pdf).

## Dependencies

- [IRIS-U^2 code](https://github.com/CRL-Technion/IRIS-UU): You will need to have the IRIS-U^2 code installed and properly configured to perform the performance evaluation step.


## Overview

The simulator takes as input the output command of the IRIS-U^2 inspection planning algorithm and produces the execution path. 
Subsequently, it utilizes the IRIS-U^2 code to calculate the performance metrics such as Points of Interest (POI), collision occurrences, and path length based on the generated execution path. 
Additionally, the code generates a video illustrating the quadcopter's path within the scenario.

![image](https://github.com/CRL-Technion/Simulator-IRIS-UU/assets/68165604/c7f0c151-b1c2-454e-86b1-453a375520d0)


## Usage

- **Input Command**: 
  Provide the output command of the IRIS-U^2 inspection planning algorithm.

- **Execution, Performance Evaluation, and Visualization**:
  Run the simulator (`main.m`) to generate the execution path, calculate performance metrics, and create visualization.

- **Instructions**:
  - Review the comments within the script to understand its functionality and dependencies.
  - Adjust the paths and parameters in the script as needed to fit your specific setup.
  - The performance metrics such as Points of Interest (POI), collision occurrences, and path length are automatically calculated during execution.
  - The simulator automatically generates a video illustrating the quadcopter's path in the scenario.


