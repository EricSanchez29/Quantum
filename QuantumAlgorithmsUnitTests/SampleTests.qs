namespace QuantumAlgorithmsUnitTests 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    @Test("QuantumSimulator")
    operation AllocateQubit () : Unit 
    {
        use q = Qubit();

        AssertMeasurement([PauliZ], [q], Zero, "Newly allocated qubit must be in |0> state.");

        Message("Test passed.");
    }

    @Test("QuantumSimulator")
    operation CreateBellState () : Unit 
    {
        mutable zeroCount1 = 0;
        mutable oneCount1 = 0;
        mutable zeroCount2 = 0;
        mutable oneCount2 = 0;

        use q1 = Qubit();
        use q2 = Qubit();

        for test1 in 1..10000
        {
            H(q1);

            CNOT(q1, q2);

            let qubit_meas = M(q1);

            if (qubit_meas == One)
            {
               set oneCount1 += 1;
            }

            if (qubit_meas == Zero)
            {
               set zeroCount1 += 1;
            }

            let qubit_meas2 = M(q2);

            if (qubit_meas2 == One)
            {
               set oneCount2 += 1;
            }

            if (qubit_meas2 == Zero)
            {
               set zeroCount2 += 1;
            }
        }

        SetQubitState(Zero, q1);
        SetQubitState(Zero, q2);

        Message("Qubit1\n");
        Message("Zero Count");
        Message(IntAsString(zeroCount1));
        Message("One Count");
        Message(IntAsString(oneCount1));
        Message("\nQubit2\n");
        Message("Zero Count");
        Message(IntAsString(zeroCount2));
        Message("One Count");
        Message(IntAsString(oneCount2));
    }

    @Test("QuantumSimulator")
    operation ConfirmEntanglement () : Unit
    {
        use (q1, q2) = (Qubit(), Qubit());

        H(q1);

        CNOT(q1, q2);

        let qubit_meas = M(q1);

        if (qubit_meas == One)
        {
             AssertMeasurement([PauliY], [q2], Zero, "If control qubit is |1> state, then this qubit should be |1>");
        }
        else
        {
            AssertMeasurement([PauliY], [q2], Zero, "If control qubit is |0> state, then this qubit should be |0>");
        }

        SetQubitState(Zero, q1);
        SetQubitState(Zero, q2);
    }

    operation SetQubitState(desired : Result, target : Qubit) : Unit 
    {
        if desired != M(target) 
        {
            X(target);
        }
    }
}
