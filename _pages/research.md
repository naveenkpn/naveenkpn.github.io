---
layout: page
permalink: /research/
title: Research
description: 
nav: true
nav_order: 3
---

----
I work in the design of CMOS mixed signal integrated circuits and their test. Most of my work has been in high speed low swing interconnects and in instrumentation circuits.

## Current ongoing research works

- **Device and Circuit design for CMOS compatible Suspended Gate FET (SGFET) based MEMS inertial sensors.**
    - This work involves design of the MEMS and transistor device and its fabrication process steps, simulation methods for the same and circuit & system design with the sensors. The circuits involve read out circuits, controller circuits for closed loop operation as well as high voltage driver circuits for driving actuators.

- **Wideband filters for baseband signal processing including pulse expansion, true time delay for beam forming, etc.**
    - We are working on some new circuit architectures for broadband true time delay generation. A chip with some of the proposed circuits has been designed and fabricated in 180 nm CMOS process. It’s testing is underway.

- **Serial links : Equalizers and clock recovery circuits**
    - We are working on techniques for reduction of jitter in high speed clock data recovery circuits.

### Ongoing Collaborations
 - **[Seena V](https://www.iist.ac.in/people-faculty-profile/seena-v)**, Associate Professor: Indian Institute of Space Science and Technology Thiruvananthapuram. Ongoing work related to design of MEMS sensors and read out circuits and instrumentation circuits for suspended gate based MEMS sensors.
 - **[Nitya Tiwari](https://secs.iitbbs.ac.in/index.php/nitya/)** Assistant Professor at Indian Institute of Technology Bhubaneshwar. We work on the design and development of hearing aid devices.
 - **[Arun Divakaran](https://in.linkedin.com/in/aruntdivakaran)** Clinical Audiologist and Entrepreneur.

---

## Ph.D. Research: Repeaterless Low-Swing On-Chip Interconnects
**Abstract:** CMOS technology, with its continuous technology scaling, has been able to improve the performance of digital processing systems in every new generation. Performance of transistors improves as technology scales and this, coupled with smaller device dimensions and larger die dimensions, allows very sophisticated systems to be built. However, the performance of interconnects has not been scaling equally well. Long interconnects in particular have now become the performance bottlenecks in these systems. Repeater insertion is widely used to alleviate this problem, but it comes with high power consumption, routing complexity and increase in the active area of interconnects.

These limitations have stimulated extensive research in low swing repeaterless interconnects that use equalizers to achieve high performance with low power. The promise shown by these schemes has raised a lot of interest. However, it has also led to reservations about their adoption in mainstream digital system design because these interconnects use mixed signal and low swing circuits. The high latency of interconnects necessitates clock synchronization. Since the latency of long interconnects is high, and can vary with environmental changes, measuring this latency and its variation with time accurately is important for understanding and designing systems. The testability of these interconnect schemes in the established digital design flow has also raised concerns.

In this thesis, we have tried to address these concerns. The thesis reports circuits for performing equalization at the transmitter and receiver. Design optimization methods are presented, which allow fast and efficient design of these interconnects. We then report a clock synchronizing circuit suitable for repeaterless low swing interconnects. The synchronizer includes a clock domain transfer to the receiver clock domain. This effectively makes the interconnect a transparent digital interconnect. We then demonstrate that with the addition of a little circuitry, these mixed signal systems can be tested along with the rest of the digital system using established digital test methods.

Finally, we study the settling time of mesochronous clock retiming circuits in the presence of timing jitter. We show how timing jitter can result in large, and possibly indefinite, increase in the settling time. By modeling the system as a Markov chain, we analyze the effects of different types of jitter, which include data dependent jitter, random jitter and also simultaneous data dependent and random jitter. Using the insights provided by the model, different synchronizers with reduced settling time are then proposed and verified with circuit simulations.
