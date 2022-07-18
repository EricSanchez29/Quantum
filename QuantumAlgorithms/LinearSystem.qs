namespace QuantumAlgorithms 
{
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;

    // HHL
    operation SolveLinearSystem (matrix: Double[][], b_vector: Double[]) : (Double[])
    {
        //let a = matrix.Count;
        let N = 2;
        let x = [0.0, size = 2];

        use state = Qubit();
        use eigenVector = Qubit();
        use ancilla = Qubit();

        // State |b> ----[U]--------------------[Ut]----- |x>
        // Eigen |0> -[H]-!-[H]-----;-------[H]--!--[H]-- |0>
        // Ancil |1> -----------[Ry(theta)]-------------- |1>
                
        // U = exp(2pi*i2^(n-1)*A)
        // where n is dependent on the eigenvalues
        // theta in Ry(theta) also dependent on the eigenvalues


        // Prepare qubits
        //
        // How do I set the state qubit using double[]?
        //PrepareArbitraryStateCP()
        SetQubitState(Zero, eigenVector);
        SetQubitState(One, ancilla);


        // Phase estimation
        H(eigenVector);

        U(state, eigenVector, matrix);
        
        //H(eigenVector);


        // Non-Unitary map

        EigenRotation(eigenVector, ancilla);

              
        
        // Reverse phase estimation
  
        //H(eigenVector);

        //U(state, eigenVector, matrix);

        //H(eigenVector);


        let test = M(eigenVector);
        let resultQ = M(state);

        // convert state qubit result to double[] x

        Reset(state);
        Reset(eigenVector);
        Reset(ancilla);

        return x;
    }

    // add to common library later
    operation SetQubitState(desired : Result, target : Qubit) : Unit 
    {
        if desired != M(target) 
        {
            X(target);
        }
    }

    // Quantum Phase Estimation
    // U = exp(2pi*i2^(n-1)*A)
    operation U(eigenVector : Qubit, estimatedPhase : Qubit, A: Double[][]) : Unit
    {
        //  Use A to make simulated A (where A is a non unitary matrix)
        //HamiltonianSimulaition

       // QFT(eigenVector, estimatedPhase);
    }


    operation HamiltonianSimulaition() : Unit
    {
        // Need to research this more

    }

    
    operation PhaseKickback() : Unit
    {

    }
    
    // Quantum Fourier Transform
    // this implementation ommits the SWAP operation
    // (this is done in the PhaseKickback() function)
    operation QFT_no_SWAP(eigenVector : Qubit, estimatedPhase : Qubit) : Unit
    {

        //cant use QTF() from library
        
    }




    operation EigenRotation(eigenVector : Qubit, ancilla : Qubit) : Unit
    {
        // Non-unitary map
        
        Ry(45.0, eigenVector);
    }


    // prints out results
    function QuantumPhaseEstimation1() : Unit
    {
        // apply controlled n*U^2^k operations

    }


    // HHL (implemented by Cai et al)
    operation Cai_SolveLinearSystem (matrix: Double[][], b_vector: Double[]) : (Double[])
    {



        //let a = matrix.Count;
        let N = 2;
        let x = [0.0, size = 2];

        use qubits = Qubit[4];

        use ancilla = Qubit();
        use reg1 = Qubit();
        use reg2 = Qubit();
        use input = Qubit();
        

        // Ancil |1> -----------[Ry(pi/8)]--[Ry(pi/16)]----- |1> Measure
        // Reg_1 |0> -------+--------!-----------|-----[H]-- |0> Measure
        // Reg_2 |0> -----+-!-[X]----------------!-----[H]-- |0> Measure
        // Input |b> -[H]-!-[H]----------------------------- |x>
        
        
        // Prepare qubits
      
        SetQubitState(One, qubits[0]);
        SetQubitState(Zero, qubits[1]);
        SetQubitState(Zero, qubits[2]);
        // How do I set the input qubit using double[]?
        //PrepareArbitraryStateCP()

        // Phase estimation
        
        H(qubits[3]);
        
        DumpMachine();

        CNOT(qubits[3], qubits[2]);

        DumpMachine();

        CNOT(qubits[2], qubits[1]);

        DumpMachine();

        X(qubits[2]);

        DumpMachine();

        H(qubits[3]);
        
        DumpMachine();

        Ry(45.0, qubits[0]);
              
        
        // Reverse phase estimation
  
        //H(eigenVector);

        //U(state, eigenVector, matrix);

        //H(eigenVector);


        let ancillaState = M(qubits[0]);
        let reg1State = M(qubits[1]);
        let reg2State = M(qubits[2]);

        // convert state qubit result to double[] x
        //

        // Reset all qubits
        ResetAll(qubits);

        return x;
    }

    // Simplified HHL implemented by Barz et al
    operation Barz_SolveLinearSystem () : (Double[])
    {
        // this operation does not solve a general system of equations
        // it will solve a matrix constructed from pre chosen eigenvalues (e1 = 1/2, e2 = 3/4)
        //
        // A = R^t * D * R
        //
        // where 
        // D is a diagonal matrix made of the the eigenvalues
        // R = Rx*Ry for some thetas, R^t is the conjugate tranpose of R
            

        use ancilla = Qubit();
        use input = Qubit();
        
        // Input |b> -[R]-;----------------;-----[R^t]--------- |x>
        // Ancil |1> -----+-[Ry(-theta/2)]-+-[Ry(theta/2)]----- |1> Measure
  
        // 
        // R()=Rx()Ry()

        // theta = -1.682 rad  
        // theta is determined before constructing the circuit
        // because the eigen values are chosen before constructing matrix A


        // Prepare qubits
        //
        // How do I set the input qubit using double[]?
        
        //PrepareArbitraryStateCP()
        SetQubitState(One, input);
        SetQubitState(One, ancilla);
        
        let pi = PI();

        DumpMachine();


        // R
        Ry(3.0*pi/8.0, input);
        
        DumpMachine();

        Rx(11.0*pi/15.0, input);

        DumpMachine();

        CNOT(input, ancilla);

        DumpMachine();

        // Ry(-theta/2)
        Ry(-1.682/2.0, ancilla);
              
        CNOT(input, ancilla);

        // Ry(theta/2)
        Ry(1.682/2.0, ancilla);

        // R^t
        Ry(3.0*pi/8.0, input);        
        DumpMachine();
        Rx(11.0*pi/15.0, input);
        DumpMachine();

        let ancillaState = M(ancilla);

        let inputState = M(input);

        DumpMachine();

        // convert state qubit result to double[] x
        let x = [0.0, size = 2];


        // Reset all qubits
        Reset(input);
        Reset(ancilla);
        
        return x;
    }
}
