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
vector<pair<int, int>> adj[101];
int main(void)
{
	ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    fstream in_stream;
    in_stream.open("in.txt", ios::in);
    int P, N, M;
    in_stream >> P >> N >> M;
    int temp = M;
    assert(P != 0);
    assert(N != 0);
    assert(M != 0);
    assert(N <= 100);
    int temp2 = N;
    vector<pair<pair<int, int>, int>> edges;
    while(M--) {
    	int a, b, w;
    	in_stream >> a >> b >> w;
    	edges.pb({{a, b}, w});
    	adj[a].pb({b, w});
    	adj[b].pb({a, w});
    }
    int S;
    in_stream >> S;
    vector<int> dist(N + 1, 1e8), done(N + 1, 0);
    dist[S] = 0;
    priority_queue <pair<ll, ll>, vector<pair<ll, ll>>, greater<pair<ll, ll>> > pq;
    pq.push({0, S});
    while(!pq.empty()) {
    	pair<int, int> cur = pq.top();
    	pq.pop();
    	if(done[cur.ss]) {
    		continue;
    	}
    	done[cur.ss] = 1;
    	for(pair<int, int> u: adj[cur.ss]) {
    		if(dist[u.ff] > dist[cur.ss] + u.ss) {
    			dist[u.ff] = dist[cur.ss] + u.ss;
    			pq.push({dist[u.ff], u.ff});
    		}
    	}
    }
    in_stream.close();
    in_stream.open("out.txt", ios::in);
    fstream wrong;
    wrong.open("wrong.txt", ios::app);
    while(N--) {
    	int a, d;
    	in_stream >> a >> d;
    	if(d != dist[a]) {
    		wrong << P << "\n" << temp2 << " " << temp << "\n";
    		for(auto u: edges) {
    			wrong << u.ff.ff << " " << u.ff.ss << " " << u.ss << "\n";
    		}
    		wrong << S << "\n\n\n\n";
    		wrong.close();
    		cout << "WRONG\n";
    		return 0;
    	}
    }
    cout << "CORRECT\n";
}