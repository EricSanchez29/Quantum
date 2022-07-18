namespace QuantumAlgorithms {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    // Optimized so there is only communication between adjacent qubits
    // adapted from Jack Hidary's Quantum Computing textbook in Cirq languange
    operation ModifiedQFT () : Unit 
    {
        // Add circuit diagram

        use qbits = Qubit[4];

        Message("Initial state:");
        DumpMachine();
        Message("");
        
        H(qbits[0]);

        rz_and_swap(qbits[0], qbits[1], 0.5);
        rz_and_swap(qbits[1], qbits[2], 0.25);
        rz_and_swap(qbits[2], qbits[3], 0.125);

        H(qbits[0]);

        rz_and_swap(qbits[0], qbits[1], 0.5);
        rz_and_swap(qbits[1], qbits[2], 0.25);

        H(qbits[0]);
        //Message("2nd state:");
        DumpMachine();
        Message("");

        rz_and_swap(qbits[0], qbits[1], 0.5);

        H(qbits[0]);

        Message("Final state:");
        DumpMachine();
        Message("");

        ResetAll(qbits);
    }

    // where rotation is in radians/pi (divided by pi for convenience)
    operation rz_and_swap(target: Qubit, control: Qubit, rotation: Double) : Unit
    {
        //let theta = rotation * 2.0;
        let theta = 0.0;
 // appear to get the same results no matter what theta
 // is there a bug?
        (Controlled Rz)([control], (theta, target));
        SWAP(target, control);
    }

    operation QFT() : Unit
    {

    }
}
