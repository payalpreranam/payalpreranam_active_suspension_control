
# Active Suspension System

## Overview

This project presents a **PD Controlled Active Suspension System** developed using MATLAB and Simulink.  
The main objective of the project is to reduce unwanted vehicle vibrations caused by road disturbances and improve ride comfort and vehicle stability.

The system compares:

- Passive Suspension System (Without Controller)
- Active Suspension System using PD Controller

The project includes:
- MATLAB simulations
- Simulink modeling
- Real-time vehicle animation
- Performance dashboard
- Road condition simulator

---

# Problem Statement

Vehicle suspension systems experience vibrations due to uneven road conditions such as:
- speed breakers
- potholes
- rough terrain

Excessive vibrations reduce:
- passenger comfort
- vehicle stability
- ride quality

This project uses a **PD controller** to minimize oscillations and improve suspension performance.

---

# Objective

- Reduce vehicle body oscillations
- Improve damping characteristics
- Reduce settling time
- Improve ride comfort
- Compare controlled and uncontrolled suspension systems

---

# Technologies Used

- MATLAB
- Simulink
- Control System Toolbox

---

# System Model

The suspension system transfer function used is:

\[
G(s)=\frac{1}{s^2+3s+2}
\]

The PD controller is defined as:

\[
C(s)=K_p+K_ds
\]

Where:

- \(K_p\) = Proportional Gain
- \(K_d\) = Derivative Gain

---

# Features

## 1. Simulink Suspension Model
- Closed-loop PD control system
- Feedback control implementation
- Controlled vs uncontrolled response comparison

## 2. MATLAB Step Response Analysis
- Step response comparison
- Performance metrics calculation
- Settling time analysis

## 3. Vehicle Animation
- Real-time vehicle body movement
- Road bump interaction
- Suspension vibration visualization

## 4. Live Performance Dashboard
- Peak oscillation analysis
- Settling time comparison
- Ride comfort improvement metrics

## 5. Road Condition Simulator
Simulation under different road conditions:
- Smooth Road
- Speed Breaker
- Pothole
- Rough Terrain

---

# Working Principle

1. Road disturbance acts as input to the suspension system.
2. The passive suspension system produces oscillations.
3. The PD controller generates corrective control action.
4. The controller improves damping and reduces oscillations.
5. System responses are compared using graphs, dashboards, and animations.

---

# Project Structure

```text
Active-Suspension-System/
│
├── MATLAB_Code/
├── Simulink_Model/
├── Results/
├── Demo_Video/
├── Documentation/
└── README.md
```

---

# Performance Improvements

The PD controlled suspension system shows:

- Reduced settling time
- Reduced oscillations
- Improved damping
- Better ride stability
- Improved passenger comfort

---

# How to Run the Project

## MATLAB Scripts

1. Open MATLAB
2. Navigate to the project folder
3. Run the required `.m` files

Example:

```matlab
run('live_dashboard.m')
```

---

## Simulink Model

1. Open MATLAB
2. Open the `.slx` Simulink model
3. Click **Run**
4. Observe the response graphs and outputs

---

# Results

The controlled suspension system demonstrated:
- smoother response
- lower vibration amplitude
- faster stabilization

compared to the uncontrolled suspension system.

---

# Future Scope

Future improvements can include:

- Adaptive Control
- PID/Fuzzy Controllers
- Semi-active suspension systems
- Real-time sensor integration
- IoT-based monitoring
- Hardware implementation using microcontrollers

---

# Conclusion

The project successfully demonstrates how a PD controller improves the performance of an active suspension system by reducing vibrations and improving ride comfort under different road conditions.

---

# Authors

Hackathon Project Team
# Anshika MG
# Payal Prerana M
