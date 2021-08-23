/*
 * DO NOT EDIT THIS FILE!
 * THIS FILE IS AUTOMATICALLY GENERATED FROM A LITERATE PROGRAM SOURCE FILE.
 */
/*

 * Copyright (c) 2003 - 2021 Codecraft, Inc.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
/*
 *++
 * Project:
 *   +elevator+ -- a test program for coroutines and ncurses.  <by Cary WR Campbell>
 *
 * Module:
 *   Pipe interface header file for commands and status messages shared 
 *   by elevator and a test process, e.g., Elevator Verification Test (EVT).
 *--
 */
/* 
 * Pipe Definitions
 */
#define ElevatorCommandsPipe "/tmp/ElevatorCommandsPipe"
#define ElevatorStatusPipe   "/tmp/ElevatorStatusPipe"
/*
 * Pipe Constants
 */
const int MAX_NAME_AND_VERSION_LEN = 25 ;
const int MAX_BUF_SIZE = 255 ;
/*
 * Pipe Externs
 */
extern const char endConfiguration[] ;
extern const char helloMessage[] ;
extern const char queryFloorLabels[] ;
extern const char queryMaxDimensions[] ;
extern const char quitTest[] ;
extern const char setBlockClearTime[] ;
extern const char setDoorOpenCloseTime[] ;
extern const char setFloorHeight[] ;
extern const char setFloorLabels[] ;
extern const char setGroundFloorLevel[] ;
extern const char setMaxCabinVelocity[] ;
extern const char setMaxCloseAttempts[] ;
extern const char setMinStoppingDistance[] ;
extern const char setNormalDoorWaitTime[] ;
extern const char setNumberOfElevators[] ;
extern const char setNumberOfFloors[] ;
extern const char userRequestedQuitTest[] ;
extern const char obstructDoorCommand[] ;
extern const char pushCarButtonCommand[] ;
extern const char pushFloorButtonCommand[] ;
extern const char P_BAD[] ;
extern const char P_OK[] ;
extern const char P_END[] ;
extern const char carLocation[] ;
extern const char doorIsClosed[] ;
extern const char doorIsLocked[] ;
extern const char doorIsAjar[] ;
extern const char doorIsOpen[] ;
extern const char indicatorIsDown[] ;
extern const char indicatorIsUp[] ;
extern const char indicatorIsOff[] ;
extern const char stopIsRequested[] ;
extern const char stopIsCleared[] ;
extern const char floorCallIsUp[] ;
extern const char floorCallIsDown[] ;
extern const char floorUpIsCleared[] ;
extern const char floorDownIsCleared[] ;
