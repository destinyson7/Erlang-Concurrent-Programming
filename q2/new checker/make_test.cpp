#include "bits/stdc++.h"
#include "ext/pb_ds/assoc_container.hpp"
#include "ext/pb_ds/tree_policy.hpp"

using namespace std;
using namespace __gnu_pbds;


#define ll long long int
#define pb push_back
#define mp make_pair
#define ff first
#define ss second
#define all(a) a.begin(),a.end()

typedef tree <ll, null_type, less <ll>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;
// order_of_key(val): returns the number of values less than val
// find_by_order(k): returns an iterator to the kth largest element (0-based)

int main(void)
{
	ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    srand(unsigned(time(0))); 
    fstream out_stream;
    out_stream.open("in.txt", ios::out);
    int P = rand() % 50 + 1;
    int N = rand() % 99 + 2, M = rand() % ((N * (N - 1)) / 2) + 1;
    M = max(M, N - 1);
    out_stream << P << "\n";
    out_stream << N << " " << M << "\n";
    vector<pair<int, int>> edges;
    for(int i = 1; i <= N; i++) {
    	for(int j = i + 1; j <= N; j++) {
    		edges.pb({i, j});
    	}
    }
    set<pair<int, int>> taken;
    for(int i = 2; i <= N; i++) {
    	int node = (rand() % (i - 1)) + 1;
    	int W = rand() % 1000;
    	out_stream << node << " " << i << " " << W << "\n";
    	taken.insert({node, i});
    	M--;
    }
 	random_shuffle(edges.begin(), edges.end());
    while(M) {
    	pair<int, int> edge = edges.back();
    	edges.pop_back();
    	if(taken.find(edge) != taken.end()) {
    		continue;
    	}
    	M--;
    	int W = rand() % 1000;
    	out_stream << edge.ff << " " << edge.ss << " " << W << "\n";
    }
    int S = rand() % N + 1;
    out_stream << S << "\n";
}