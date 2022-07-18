namespace QuantumAlgorithmsUnitTests {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open BasicAlgorithms;

    @Test("QuantumSimulator")
    operation TestBellState () : Unit 
    {
        GetBellsState();
    }
}
