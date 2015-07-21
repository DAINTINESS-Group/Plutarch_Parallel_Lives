package tableClustering.analysis;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import tableClustering.commons.Cluster;
import tableClustering.commons.ClusterCollector;
import data.pplSqlSchema.PPLTable;


public class AgglomerativeClusterExtractor implements ClusterExtractor{

	

	@Override
	public ClusterCollector extractAtMostKClusters(TreeMap<String, PPLTable> tables,
			int numClusters, float birthWeight, float deathWeight, float changeWeight) {
		
		ClusterCollector initSolution = new ClusterCollector();
		this.init(tables, initSolution);
		//System.out.println("init "+initSolution.getPhases().size());
		//this.preProcessingTime(transitionHistory, initSolution);
		//System.out.println("timePreProcessing "+initSolution.getPhases().size());

		
		
		ClusterCollector currentSolution = new ClusterCollector();
		currentSolution = this.newClusterCollector(tables, initSolution, birthWeight, deathWeight, changeWeight);

		while (currentSolution.getClusters().size() > numClusters){
			currentSolution = this.newClusterCollector(tables, currentSolution, birthWeight, deathWeight, changeWeight);
		}
		return currentSolution;
		
	}
	
	public ClusterCollector newClusterCollector(TreeMap<String,PPLTable> pplTables, ClusterCollector prevCollector,float birthWeight, float deathWeight ,float changeWeight){
		
		ClusterCollector newCollector = new ClusterCollector();
		ArrayList<Cluster> newClusters = new ArrayList<Cluster>();
		ArrayList<Cluster> oldClusters = prevCollector.getClusters();
		int oldSize = oldClusters.size();
		if (oldSize == 0){
			
			System.out.println("Sth went terribly worng at method XXX");
			System.exit(-10);
		}

		//compute the distances for all the bloody phases
		//TODO add it at phase collector to move on !$#@$#%$^$%&%&
		double distances[] = new double[oldSize];
		distances[0] = Double.MAX_VALUE;
		int pI = 0;
		
	    Iterator<Cluster> clusterIter = oldClusters.iterator();
	    Cluster previousCluster = clusterIter.next();
	    while (clusterIter.hasNext()){
	      Cluster c = clusterIter.next();
	      pI++;
	      distances[pI] = c.distance(previousCluster,birthWeight,deathWeight,changeWeight);
	      
	      previousCluster = c;
	    }


		//find the two most similar phases in the old collection
	    int posI=-1; double minDist = Double.MAX_VALUE;
	    for(int i=1; i<oldSize; i++){
	    	if(distances[i]<minDist){
	    		posI = i;
	    		minDist = distances[i];
	    	}
	    }
	    //merge them in a new phase. Merge posI with its PREVIOUS (ATTN!!)
		Cluster toMerge = oldClusters.get(posI-1);
		Cluster newCluster = toMerge.mergeWithNextCluster(oldClusters.get(posI));

		for(int i=0; i < posI-1; i++){
			Cluster c = oldClusters.get(i);
			newClusters.add(c);
		}
		//add the new i_new = merge(i,i+1) to the new phases
		newClusters.add(newCluster);
		//add the i+1, .. last to the new phases
		if(posI<oldSize-1){
			for(int i=posI+1; i < oldSize; i++){
				Cluster c = oldClusters.get(i);
				newClusters.add(c);
			}		
		}
		newCollector.setClusters(newClusters);

		return newCollector;
	}
	
	
	public ClusterCollector init(TreeMap<String,PPLTable> pplTables, ClusterCollector clusterCollector){
		
		for (Map.Entry<String,PPLTable> pplTable : pplTables.entrySet()) {
			Cluster c = new Cluster(pplTable.getValue().getBirthVersionID(),pplTable.getValue().getDeathVersionID(),pplTable.getValue().getTotalChanges());
			clusterCollector.addCluster(c);
			
		}
		return clusterCollector;
	}

}