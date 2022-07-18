namespace QuantumAlgorithms {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open BasicAlgorithms;
    
    @EntryPoint()
    operation Main () : Unit 
    {   
        GetBellsState();


        // demonstrate QFT, QPE and then linear system solver

        // QFT
        ModifiedQFT();


        // QPE
        //QuantumPhaseEstimation();




        //let matrix = [[0.0, size = 2],[0.0, size = 2]];
   
        let matrix = [ [ 1.0, 0.0], [0.0, 1.0] ];

        //let b_vector = [0.0, size = 2];
        
        let b_vector = [2.0, 3.0];

        //let results = Cai_SolveLinearSystem(matrix, b_vector);

        //let results1 = Barz_SolveLinearSystem();
    }
}
