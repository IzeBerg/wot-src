package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SummaryCommonScoresVO extends DAAPIDataClass
   {
       
      
      public var battles:SummaryViewVO;
      
      public var wins:SummaryViewVO;
      
      public var coolSigns:SummaryViewVO;
      
      public var maxDestroyed:SummaryViewVO;
      
      public var maxExperience:SummaryViewVO;
      
      public var avgExperience:SummaryViewVO;
      
      public var hits:SummaryViewVO;
      
      public var avgDamage:SummaryViewVO;
      
      public var personalScore:SummaryViewVO;
      
      public function SummaryCommonScoresVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(hasOwnProperty(param1))
         {
            this[param1] = new SummaryViewVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.battles.dispose();
         this.battles = null;
         this.wins.dispose();
         this.wins = null;
         this.coolSigns.dispose();
         this.coolSigns = null;
         this.maxDestroyed.dispose();
         this.maxDestroyed = null;
         this.maxExperience.dispose();
         this.maxExperience = null;
         this.avgExperience.dispose();
         this.avgExperience = null;
         this.hits.dispose();
         this.hits = null;
         this.avgDamage.dispose();
         this.avgDamage = null;
         this.personalScore.dispose();
         this.personalScore = null;
         super.onDispose();
      }
   }
}
