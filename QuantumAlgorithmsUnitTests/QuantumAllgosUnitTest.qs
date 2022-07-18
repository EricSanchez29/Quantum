namespace QuantumAlgorithmsUnitTests 
{
    open QuantumAlgorithms;
    open Microsoft.Quantum.Canon;
    //open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    //open Microsoft.Quantum.Math;
    open QuantumAlgorithms;


    @Test("QuantumSimulator")
    operation Operation1 () : Unit 
    {
        ModifiedQFT();
    }
}
