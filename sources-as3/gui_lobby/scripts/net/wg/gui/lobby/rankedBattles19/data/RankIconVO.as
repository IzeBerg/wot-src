package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankIconVO extends DAAPIDataClass
   {
      
      private static const FIELD_SHIELD:String = "shield";
       
      
      public var imageSrc:String = "";
      
      public var smallImageSrc:String = "";
      
      public var isEnabled:Boolean = true;
      
      public var hasTooltip:Boolean = true;
      
      public var rankID:String = "";
      
      public var shield:RankShieldVO = null;
      
      public function RankIconVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.shield)
         {
            this.shield.dispose();
            this.shield = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param2 && param1 == FIELD_SHIELD)
         {
            this.shield = new RankShieldVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
