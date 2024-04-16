package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DivisionProgressBlockVO extends DAAPIDataClass
   {
      
      private static const FIELD_SHIELD:String = "shield";
      
      private static const FIELD_STEPS_DATA:String = "stepsData";
       
      
      public var stepsData:StepsContainerVO = null;
      
      public var shield:DivisionShieldVO = null;
      
      public var rankLabel:String = "";
      
      public var smallImageSrc:String = "";
      
      public var bigImageSrc:String = "";
      
      public var hugeImageSrc:String = "";
      
      public var isAcquired:Boolean = false;
      
      public var hasTooltip:Boolean = true;
      
      public var rankID:String = "";
      
      public function DivisionProgressBlockVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_STEPS_DATA)
         {
            this.stepsData = new StepsContainerVO(param2);
            return false;
         }
         if(param1 == FIELD_SHIELD && param2)
         {
            this.shield = new DivisionShieldVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.stepsData)
         {
            this.stepsData.dispose();
            this.stepsData = null;
         }
         if(this.shield)
         {
            this.shield.dispose();
            this.shield = null;
         }
         super.onDispose();
      }
   }
}
