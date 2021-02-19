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
typedef pair<ll, ll> pll;
typedef vector<ll> vi;
typedef vector<vi> vvi;

typedef tree <ll, null_type, less <ll>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;
// order_of_key(val): returns the number of values less than val
// find_by_order(k): returns an iterator to the kth largest element (0-based)
// vector<int> adj[101];
// int color[101];
int main(void)
{
	ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    fstream graph;
    graph.open("in.txt", ios::in);
    int P,N,M;
    graph >>P>> N >> M;
    vector<pair<ll,ll>>adj[N+1];
    // vector<pair<ll,pair<ll, ll>>> edges;

    int deg = 0,src;
    for(int i = 0; i < M; i++) {
    	int a, b,c;
    	graph >> a >> b>>c;
    	adj[a].pb({b,c});
    	adj[b].pb({a,c});
    }
    graph>>src;
    int dist[N+1]; 
  
    // Step 1: Initialize distances from src to all other vertices 
    // as INFINITE 
    for (int i = 0; i <=N; i++) 
        dist[i] = 134217727; 
    dist[src] = 0; 
    priority_queue<pll,vector<pll>,greater<pll>> pq;
    pq.push({0,src});
    while(!pq.empty()){
        ll x=pq.top().ss;
        ll di=pq.top().ff;
        pq.pop();
        for (auto u : adj[x]){
            ll ne=u.ff;
            ll we=u.ss;
            if(dist[ne]>(di+we)){
                dist[ne]=di+we;
                pq.push({dist[ne],ne});
            }
        }
    }
 
 
  
    // Step 2: Relax all edges |V| - 1 times. A simple shortest 
    // path from src to any other vertex can have at-most |V| - 1 
    // edges 
    // for (int i = 1; i <= N - 1; i++) { 
    //     for (int j = 0; j < M; j++) { 
    //         int u = graph->edge[j].src; 
    //         int v = graph->edge[j].dest; 
    //         int weight = graph->edge[j].weight; 
    //         if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) 
    //             dist[v] = dist[u] + weight; 
    //     } 
    // } 
  
    // for(int i = 1; i <= N; i++) {
    // 	deg = max(deg, (int)adj[i].size());
    // }
    // int max_allowed = deg + 1;
    fstream ans;
    ans.open("output.txt", ios::in);
    // int used;
    // ans >> used;
    // if(used > max_allowed) {
    	// cout << "WRONG: more than " << used <<" colors used\n";
    	// return 0;
    // }
    int val,node;
    for(int i = 1; i <= N; i++) {
    	ans >> node>>val;
    	if(val != dist[i]) {
    		cout << node<<"WRONG\n"<<val<<" "<<dist[i];
    		return 0;
    	}
    }
    // for(int i = 1; i <= N; i++) {
    // 	for(int j: adj[i]) {
    // 		if(color[i] == color[j]) {
    // 			cout << "WRONG: color of " << i << " and " << j << " is same but they share an edge\n";
    // 			return 0;
    // 		}
    // 	}
    // }
    cout << "CORRECT\n";
    return 0;	
}