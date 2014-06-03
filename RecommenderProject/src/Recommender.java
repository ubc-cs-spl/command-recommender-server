import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

public class Recommender {
	private static Gson parser;
	private class Recommendations implements Serializable{
		private String user_id;
		private Recommendation[] recommendations;
		
		public Recommendations(String user_id, Recommendation[] recommendations){
			
			this.recommendations = recommendations;
		}
	}
	
	private class Recommendation implements Serializable{
		private static final long serialVersionUID = 1L;
		public String commandId;
		public String type;
		public String description;
		
		public Recommendation(String commandId, String type, String description){
			this.commandId = commandId;
			this.type = type;
			this.description = description;
		}
	}

	public static void main(String[] args) {
		int sleepTime = Integer.parseInt(args[0]);
		Recommender recommender = new Recommender();
		parser = new Gson();
		Recommendation[] recommendaitonArr = new Recommendation[10];
		try {
			Thread.sleep(sleepTime*1000);
			for(int i = 0; i< 10; i++){
				recommendaitonArr[i] = recommender.new Recommendation("what"+i, "kind"+i, "descriptition"+i);
			}
			//Recommendations recommendations = recommender.new Recommendations(args[1],  recommendaitonArr);
			System.out.println(parser.toJson(recommendaitonArr));
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Done Sleeping");
	}
}
