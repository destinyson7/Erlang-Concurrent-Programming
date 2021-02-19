
# Distributed Systems Assignment 2

## Erlang

### Running the code

```
erlc <file>.erl
erl -noshell -s <file> main <input file> <output file> -s init stop
```

---

### Problem 1

-  **Description**:

	Process 0 spawns Process 1 and sends the token to it and waits for the token from process (P - 1). Process i receives the token from process (i - 1) and spawns the process (i + 1) and passes the token to it. If it is process (P - 1), then it passes the token back to process 0 and the program ends.

-  **Analysis**:

	- Time Complexity is O\(P\)

---

### Problem 2

-  **Description**:

	- We have to implement a distributed algorithm for shortest paths.

	- A very good option, according to me, is to use the Bellman-Ford algorithm. The idea is that for every iteration in the loop of V - 1, we can relax the edges parallely. So we distribute the edges roughly equally to all the processes.

	- Each process then relaxes only those subset of edges and then passes its distance array to the root process.

	- The root process receives the distance array from all the other processes (it also has its own distance array), and then it merges them to get an updated distance array (taking minimum ith element from all the distances arrays for each i), and then sends the updated distance array to all the processes which the processes use in their next iteration.

	- This process goes on until there is no updation in the distance array by any process, which will last a maximum of V - 1 iterations.

-  **Analysis**:

	- Time Complexity - O\(VE/P\) + Message Complexity

	- Message Complexity - Root process sends distance array to P - 1 processes, and then it receives distance array back. This happens for a maximum of V - 1 iterations. So the number of messages are O\(PV\). Message Complexity is thus Average Message Passing Time * O\(PV\).

---

### Assignment by

- Tanish Lad (2018114005)
