namespace BasicAlgorithms 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;

    operation GetBellsState () : Unit 
    {
            use qubits = Qubit[2];

            Message("Initial state:");

            DumpMachine();

            Message("");

            H(qubits[0]);

            Message("Apply hadamard to q0");
            DumpMachine();
            Message("");

            CNOT(qubits[0], qubits[1]);

            Message("Apply CNOT q0 controlling q1");
            DumpMachine();

            Message("");

            ResetAll(qubits);
    }
}