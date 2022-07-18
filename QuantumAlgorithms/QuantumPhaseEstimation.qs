namespace QuantumAlgorithms 
{

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;

    operation QuantumPhaseEstimation () : Unit 
    {
        //                                                           _________
        // Reg        |0> -[H]----;----------------------------------| QFT^t |-- M
        //            |0> -[H]----|----------;-----------------------|       |-- M
        //            ...         |          |                     --|       |
        //            |0> -[H]----|----------|--------------;--------|_______|-- M
        // Eigenstate |1> ----[U^(2^0)]--[U^(2^1)]-...-[U^(2^k-1)]--

        let n = 4;
        let m = 1;

        use top_reg = Qubit[n];
        use bottom_reg = Qubit[m];
        X(bottom_reg[0]);

        Message("Initial state:");

        DumpMachine();

        // Superposition (top register)
        for k in 0..n-1
        {
            H(top_reg[k]);
        }

        DumpMachine();

        // Controlled U operation

        // create unitary matrix
        // U = TensorProduct(X, Z)
        //
        // use U = Z for now

        // apply controlled U gate (U^(2^k)) 
        for k in 0..n-1
        {
            if (k == 0)
            {
                // only apply gate once
                // U^(2^0) = U^1
                CZ(top_reg[k], bottom_reg[0]);
            } 
            else
            {
                // if k > 0
                // U^(k^2) = U^2j (where j is an even number) = U^2 = I
                (Controlled I)([top_reg[k]], bottom_reg[0]);
            }
        }

        //Inverse QFT
        for k in 0..(n-2)
        {
            H(top_reg[k]);
            let target = k + 1;

            for j in 0..target-1
            {
                let theta = PowD(-2.0, IntAsDouble(j - target));
      
                (Controlled Rz)([top_reg[j]], (theta, top_reg[target]));
                DumpMachine();
            }
        }
        H(top_reg[n-1]);

        // Measurement
        Message("Estimated Eigenvalues (of a unitary matrix):");
       
        let phase =  IntAsDouble(ResultArrayAsInt(MultiM(top_reg)));
        Message("Phase:" + DoubleAsString(phase));

        // need to convert using, complex eigenvalue = e ^ i*2pi*phase
        let real = Cos(PI() * 2.0 * phase);
        let imaginary = Sin(PI() * 2.0 * phase);
        
        Message("Real:" + DoubleAsString(real));
        Message("Imaginary:" + DoubleAsString(imaginary));

        DumpMachine();

        ResetAll(top_reg);
        ResetAll(bottom_reg);
    }
}
